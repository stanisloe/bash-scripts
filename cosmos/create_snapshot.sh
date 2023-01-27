#!/bin/bash

echo "Starting backup"

source $HOME/.cosmos_profile

HEALTH_CHECK_ID=$1
SNAPSHOTS_DIR="snapshots"
SNAPSHOT_NAME=$(date +%Y_%m_%d_%H)"_okp4_snapshot"

mkdir -p $HOME/$SNAPSHOTS_DIR

sudo systemctl disable $COSMOS_SERVICE_NAME
sudo systemctl stop $COSMOS_SERVICE_NAME
sleep 5

#--exclude="$COSMOS_NODE_PATH/data/priv_validator_state.json"
tar -czf "$HOME/$SNAPSHOTS_DIR/$SNAPSHOT_NAME.tar.gz" -C $COSMOS_NODE_PATH/ data

sudo systemctl enable $COSMOS_SERVICE_NAME
sudo systemctl restart $COSMOS_SERVICE_NAME

for filename in $HOME/$SNAPSHOTS_DIR/*.gz; do
    if [ ! -z "${filename##*$SNAPSHOT_NAME*}" ]; then
        echo "Removing $filename"
        rm $filename
    fi
done

sleep 100

is_catching_up=$(/usr/bin/curl -s $COSMOS_NODE_ADDR/status | jq -r '.result.sync_info.catching_up')
echo "Catching up status $is_catching_up"
/usr/bin/curl -fsS -m 10 --retry 5 -o /dev/null "https://hc-ping.com/$HEALTH_CHECK_ID"

if [ "$is_catching_up" == "false" ]; then
    echo "Node is synced"
else
    echo "Node is still catching up"
fi

echo "Backup finished"