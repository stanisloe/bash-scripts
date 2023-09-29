source $HOME/.bash_profile

AMOUNT=$1
if [ -z "$AMOUNT" ];
then 
    echo "Unbond amount not provided. Enter it now";
    read AMOUNT
fi

$COSMOS_BINARY tx staking unbond $COSMOS_VALOPER $AMOUNT$COSMOS_TOKEN --from $COSMOS_WALLET --fees 5000$COSMOS_TOKEN -y