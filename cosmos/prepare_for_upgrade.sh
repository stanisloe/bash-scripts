BINARY_URL=$1
UPGRADE_NAME=$2

if [ -z "$BINARY_URL" ];
then 
    echo "Binary url wasn't provided. Enter it now";
    read BINARY_URL
fi
if [ -z "$UPGRADE_NAME" ];
then 
    echo "Upgrade name wasn't provided. Enter it now";
    read UPGRADE_NAME
fi

wget -O $HOME/$COSMOS_BINARY $BINARY_URL
sudo chmod +x $HOME/$COSMOS_BINARY
mv $HOME/$COSMOS_BINARY $(which $COSMOS_BINARY)
$COSMOS_BINARY version

upgrade_path=$HOME/$COSMOS_NODE_FOLDER/cosmovisor/upgrades/$UPGRADE_NAME/bin
mkdir -p $upgrade_path
cp $(which $COSMOS_BINARY) $upgrade_path/