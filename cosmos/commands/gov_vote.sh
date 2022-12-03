source $HOME/.bash_profile

PROPOSAL_ID=$1
PROPOSAL_VOTE=$2

if [ -z "$PROPOSAL_ID" ];
then 
    echo "Proposal id wasn't provided. Enter it now";
    read PROPOSAL_ID
fi
if [ -z "$PROPOSAL_VOTE" ];
then 
    echo "Proposal vote wasn't provided. Select one of the following:\nyes\nno\nabstain";
    read PROPOSAL_VOTE
fi

$COSMOS_BINARY tx gov vote $PROPOSAL_ID $PROPOSAL_VOTE --from $COSMOS_WALLET --fees $COSMOS_FEE$COSMOS_TOKEN -y