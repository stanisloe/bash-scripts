echo "Start cosmovisor install"
if [ -z "$COSMOS_SERVICE_NAME" ]; then
    echo "service name not set. creating service name"
    COSMOS_SERVICE_NAME=$COSMOS_BINARY-cosmovisor.service
    bash <(curl -s https://raw.githubusercontent.com/stanisloe/bash-scripts/master/general/insert_variable.sh) \
    -n COSMOS_SERVICE_NAME -v "$COSMOS_BINARY-cosmovisor.service" -f $COSMOS_PROFILE_FILE_NAME
fi
echo "service name is $COSMOS_SERVICE_NAME"

if [ -f /etc/systemd/system/$COSMOS_SERVICE_NAME ]; then
    echo "$COSMOS_SERVICE_NAME service file already exists, exiting"
    exit 1
fi


go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@latest

echo "initializing cosmovisor"
export DAEMON_NAME=$COSMOS_BINARY
export DAEMON_HOME=$COSMOS_NODE_PATH
cosmovisor init $(which $COSMOS_BINARY)

echo "createing service file"
sudo tee /etc/systemd/system/$COSMOS_SERVICE_NAME > /dev/null <<EOF
[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=always
LimitNOFILE=4096

Environment="DAEMON_NAME=$DAEMON_NAME"
Environment="DAEMON_HOME=$DAEMON_HOME"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="UNSAFE_SKIP_BACKUP=true"

[Install]
WantedBy=multi-user.target
EOF