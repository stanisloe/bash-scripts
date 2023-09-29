source $HOME/.bash_profile

VALOPER_TO=$1
if [ -z "$VALOPER_TO" ];
then 
    echo "Target valoper not provided. Enter it now";
    read VALOPER_TO
fi

$COSMOS_BINARY tx staking redelegate $COSMOS_VALOPER $VALOPER_TO 50000$COSMOS_TOKEN \
--from $COSMOS_WALLET \
$COSMOS_GAS \
-y