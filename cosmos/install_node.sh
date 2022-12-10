source $HOME/.bash_profile

bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/cosmos/init_node.sh)
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/cosmos/setup_ports.sh)
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/cosmos/add_wallet.sh)
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/cosmos/install_cosmovisor.sh)
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/cosmos/install_commands.sh)

source $HOME/$COSMOS_VARIABLES_PROFILE

sudo systemctl daemon-reload && \
sudo systemctl enable $COSMOS_SERVICE_NAME && \
sudo systemctl restart $COSMOS_SERVICE_NAME