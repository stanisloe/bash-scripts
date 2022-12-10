$COSMOS_BINARY keys add $COSMOS_WALLET $1
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/cosmos/insert_variable.sh) \
COSMOS_VALOPER $($COSMOS_BINARY keys show $COSMOS_WALLET --bech val -a) && \
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/cosmos/insert_variable.sh) \
COSMOS_WALLET_ADDRESS $($COSMOS_BINARY keys show $COSMOS_WALLET --address)