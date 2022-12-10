COSMOS_SERVICE_NAME=$COSMOS_BINARY-cosmovisor.service
echo "export COSMOS_SERVICE_NAME=$COSMOS_SERVICE_NAME" >> $HOME/$COSMOS_VARIABLES_PROFILE

go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@latest
export DAEMON_NAME=$COSMOS_BINARY
export DAEMON_HOME=$COSMOS_NODE_PATH
cosmovisor init $(which $COSMOS_BINARY)
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