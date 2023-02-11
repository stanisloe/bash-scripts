source $HOME/.bash_profile

bash <(curl -s https://raw.githubusercontent.com/stanisloe/bash-scripts/master/cosmos/init_node.sh)
bash <(curl -s https://raw.githubusercontent.com/stanisloe/bash-scripts/master/cosmos/setup_ports.sh)
bash <(curl -s https://raw.githubusercontent.com/stanisloe/bash-scripts/master/cosmos/add_wallet.sh)
source $HOME/$COSMOS_PROFILE_FILE_NAME
bash <(curl -s https://raw.githubusercontent.com/stanisloe/bash-scripts/master/cosmos/install_cosmovisor_2.sh)
source $HOME/$COSMOS_PROFILE_FILE_NAME
bash <(curl -s https://raw.githubusercontent.com/stanisloe/bash-scripts/master/cosmos/install_commands.sh)

source $HOME/$COSMOS_PROFILE_FILE_NAME

sudo systemctl daemon-reload && \
sudo systemctl enable $COSMOS_SERVICE_NAME && \
sudo systemctl restart $COSMOS_SERVICE_NAME