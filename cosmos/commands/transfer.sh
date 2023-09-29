source $HOME/.bash_profile

WALLET_TO=$1
AMOUNT=$2
if [ -z "$WALLET_TO" ];
then 
    echo "Target wallet not provided. Enter it now";
    read WALLET_TO
fi
if [ -z "$AMOUNT" ];
then 
    echo "Amount not provided. Enter it now";
    read AMOUNT
fi

$COSMOS_BINARY tx bank send $COSMOS_WALLET $WALLET_TO $AMOUNT$COSMOS_TOKEN --fees $COSMOS_FEE$COSMOS_TOKEN -y
