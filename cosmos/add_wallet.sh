$COSMOS_BINARY keys add $COSMOS_WALLET $1 && \
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/general/insert_variable.sh) \
    -n COSMOS_VALOPER -v $($COSMOS_BINARY keys show $COSMOS_WALLET --bech val -a) $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/general/insert_variable.sh) \
    -n COSMOS_WALLET_ADDRESS -v $($COSMOS_BINARY keys show $COSMOS_WALLET --address) $COSMOS_PROFILE_FILE_NAME