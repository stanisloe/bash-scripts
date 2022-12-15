PASSPHRASE=$1
AMOUNT=$2

if [ -z "$PASSPHRASE" ];
then 
    echo "Passphrase wasn't provided. Enter it now";
    read PASSPHRASE
fi
if [ -z "$AMOUNT" ];
then 
    echo "Amount wasn't provided. Enter it now";
    read AMOUNT
fi
if [ -z "$GAS" ];
then 
    echo "Gas expression wasn't provided. Skipping it";
fi


yes "$PASSPHRASE" | $(/usr/bin/which $COSMOS_BINARY) tx staking delegate $COSMOS_VALOPER $AMOUNT$COSMOS_TOKEN --from $COSMOS_WALLET_ADDRESS --chain-id $COSMOS_CHAIN --fees $COSMOS_FEE$COSMOS_TOKEN $GAS -y