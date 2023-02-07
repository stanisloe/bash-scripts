echo "Start setup ports"

sed -i.bak -e "\
s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:$((COSMOS_NODE_ID+26))658\"%; \
s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://$COSMOS_NODE_ADDR\"%; \
s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:$((COSMOS_NODE_ID+6))060\"%; \
s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:$((COSMOS_NODE_ID+26))656\"%; \
s%^external_address = \"\"%external_address = \"`echo $(wget -qO- eth0.me):$((COSMOS_NODE_ID+26))656`\"%; \
s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":$((COSMOS_NODE_ID+26))660\"%" $COSMOS_NODE_PATH/config/config.toml && \
sed -i.bak -e "\
s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:$((COSMOS_NODE_ID+1))317\"%; \
s%^address = \":8080\"%address = \":$((COSMOS_NODE_ID+8))080\"%; \
s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:$((COSMOS_NODE_ID+9))090\"%; \
s%^address = \"0.0.0.0:8545\"%address = \"0.0.0.0:$((COSMOS_NODE_ID+8))545\"%; \
s%^ws-address = \"0.0.0.0:854\"%ws-address = \"0.0.0.0:$((COSMOS_NODE_ID+8))546\"%; \
s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:$((COSMOS_NODE_ID+9))091\"%" $COSMOS_NODE_PATH/config/app.toml && \
$COSMOS_BINARY config node tcp://$COSMOS_NODE_ADDR