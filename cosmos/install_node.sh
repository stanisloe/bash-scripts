source $HOME/.bash_profile

COSMOS_NODE_PATH=$HOME/$COSMOS_NODE_FOLDER
echo "export COSMOS_NODE_PATH=$HOME/$COSMOS_NODE_FOLDER" >> $HOME/$COSMOS_PROFILE_FILE_NAME

if [ ! -z "$COSMOS_NODE_BINARY_URL" ]; then
    sudo wget -O /usr/bin/$COSMOS_BINARY $COSMOS_NODE_BINARY_URL
    sudo chmod +x /usr/bin/$COSMOS_BINARY
elif [ ! -z "$COSMOS_NODE_REPOSITORY_URL" ]; then
    git clone $COSMOS_NODE_REPOSITORY_URL && cd $(basename $_ .git)
    if [ ! -z "$COSMOS_NODE_GIT_BRANCH" ]; then
        echo "checking out branch $COSMOS_NODE_GIT_BRANCH"
        git checkout $COSMOS_NODE_GIT_BRANCH
    elif [ ! -z "$COSMOS_NODE_GIT_TAG" ]; then
        echo "checking out tag $COSMOS_NODE_GIT_TAG"
        git checkout tags/$COSMOS_NODE_GIT_TAG -b $COSMOS_NODE_GIT_TAG
    fi
    make install
    cd $HOME
fi

echo "Cosmos binary version is:" && $COSMOS_BINARY version

$COSMOS_BINARY init $COSMOS_MONIKER --chain-id $COSMOS_CHAIN && \
$COSMOS_BINARY config chain-id $COSMOS_CHAIN && \
$COSMOS_BINARY config keyring-backend test && \
$COSMOS_BINARY config node tcp://$COSMOS_NODE_ADDR

$COSMOS_BINARY keys add $COSMOS_WALLET

COSMOS_VALOPER=$($COSMOS_BINARY keys show $WALLET --bech val -a) && \
COSMOS_WALLET_ADDRESS=$($COSMOS_BINARY keys show $COSMOS_WALLET --address) && \
echo "export COSMOS_VALOPER=$COSMOS_VALOPER" >> $HOME/$COSMOS_PROFILE_FILE_NAME && \
echo "export COSMOS_WALLET_ADDRESS=$COSMOS_WALLET_ADDRESS" >> $HOME/$COSMOS_PROFILE_FILE_NAME


sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$COSMOS_PEERS\"/; s/^seeds *=.*/seeds = \"$COSMOS_SEEDS\"/" $COSMOS_NODE_PATH/config/config.toml

if [ ! -z "$COSMOS_GENESIS_URL" ]; then
    wget -O $COSMOS_NODE_PATH/config/genesis.json $COSMOS_GENESIS_URL
    echo "genesis json hashsum:"
    md5sum genesis.json $COSMOS_NODE_PATH/config/genesis.json
fi
if [ ! -z "$COSMOS_ADDRBOOK_URL" ]; then
    wget -O $COSMOS_NODE_PATH/config/addrbook.json $COSMOS_ADDRBOOK_URL
fi


sed -i.bak -e "\
s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:$((COSMOS_NODE_ID+26))658\"%; \
s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://$COSMOS_NODE_ADDR\"%; \
s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:$((COSMOS_NODE_ID+6))060\"%; \
s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:$((COSMOS_NODE_ID+26))656\"%; \
s%^external_address = \"\"%external_address = \"`echo $(wget -qO- eth0.me):$((COSMOS_NODE_ID+26))656`\"%; \
s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":$((COSMOS_NODE_ID+26))660\"%" $COSMOS_NODE_PATH/config/config.toml

sed -i.bak -e "\
s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:$((COSMOS_NODE_ID+1))317\"%; \
s%^address = \":8080\"%address = \":$((COSMOS_NODE_ID+8))080\"%; \
s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:$((COSMOS_NODE_ID+9))090\"%; \
s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:$((COSMOS_NODE_ID+9))091\"%" $COSMOS_NODE_PATH/config/app.toml


indexer="null" && \
snapshot_interval="1000" && \
pruning="custom" && \
pruning_keep_recent="1000" && \
pruning_keep_every="0" && \
pruning_interval="100" && \
min_retain_blocks="1" && \
inter_block_cache="false" && \
sed -i.bak -e "s/^indexer *=.*/indexer = \"$indexer\"/" $COSMOS_NODE_PATH/config/config.toml && \
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" $COSMOS_NODE_PATH/config/app.toml && \
sed -i.bak -e "s/^pruning *=.*/pruning = \"$pruning\"/" $COSMOS_NODE_PATH/config/app.toml && \
sed -i.bak -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $COSMOS_NODE_PATH/config/app.toml && \
sed -i.bak -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $COSMOS_NODE_PATH/config/app.toml && \
sed -i.bak -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $COSMOS_NODE_PATH/config/app.toml && \
sed -i.bak -e "s/^min-retain-blocks *=.*/min-retain-blocks = \"$min_retain_blocks\"/" $COSMOS_NODE_PATH/config/app.toml && \
sed -i.bak -e "s/^inter-block-cache *=.*/inter-block-cache = \"$inter_block_cache\"/" $COSMOS_NODE_PATH/config/app.toml


COSMOS_SERVICE_NAME=$COSMOS_BINARY-cosmovisor.service
echo "export COSMOS_SERVICE_NAME=$COSMOS_SERVICE_NAME" >> $HOME/$COSMOS_PROFILE_FILE_NAME

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

source $HOME/$COSMOS_PROFILE_FILE_NAME

sudo systemctl daemon-reload && \
sudo systemctl enable $COSMOS_SERVICE_NAME && \
sudo systemctl restart $COSMOS_SERVICE_NAME

bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/cosmos/install_commands.sh)