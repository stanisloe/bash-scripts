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

$COSMOS_BINARY init "$COSMOS_MONIKER" --chain-id $COSMOS_CHAIN && \
$COSMOS_BINARY config chain-id $COSMOS_CHAIN && \
$COSMOS_BINARY config keyring-backend os && \
$COSMOS_BINARY config node tcp://$COSMOS_NODE_ADDR

sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$COSMOS_PEERS\"/; s/^seeds *=.*/seeds = \"$COSMOS_SEEDS\"/" $COSMOS_NODE_PATH/config/config.toml

if [ ! -z "$COSMOS_GENESIS_URL" ]; then
    wget -O $COSMOS_NODE_PATH/config/genesis.json $COSMOS_GENESIS_URL
    echo "genesis json hashsum:"
    md5sum genesis.json $COSMOS_NODE_PATH/config/genesis.json
fi
if [ ! -z "$COSMOS_ADDRBOOK_URL" ]; then
    wget -O $COSMOS_NODE_PATH/config/addrbook.json $COSMOS_ADDRBOOK_URL
fi

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

if [ ! -z "$COSMOS_STATE_SYNC_RPC" ]; then
    LATEST_HEIGHT=$(curl -s $STATE_SYNC_RPC/block | jq -r .result.block.header.height)
    SYNC_BLOCK_HEIGHT=$(($LATEST_HEIGHT - 2000))
    SYNC_BLOCK_HASH=$(curl -s "$STATE_SYNC_RPC/block?height=$SYNC_BLOCK_HEIGHT" | jq -r .result.block_id.hash)

    sed -i \
    -e "s|^enable *=.*|enable = true|" \
    -e "s|^rpc_servers *=.*|rpc_servers = \"$STATE_SYNC_RPC,$STATE_SYNC_RPC\"|" \
    -e "s|^trust_height *=.*|trust_height = $SYNC_BLOCK_HEIGHT|" \
    -e "s|^trust_hash *=.*|trust_hash = \"$SYNC_BLOCK_HASH\"|" \
    -e "s|^persistent_peers *=.*|persistent_peers = \"$STATE_SYNC_PEER\"|" \
    $HOME/$COSMOS_NODE_FOLDER/config/config.toml
fi