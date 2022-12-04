rm -rf $HOME/cosmos_scripts
mkdir $HOME/cosmos_scripts

github_command_url="https://raw.githubusercontent.com/stasjara/bash-scripts/master/cosmos/commands/"
declare -a command_names=(gov_vote)
for command_name in "${command_names[@]}"
do
    command_file="$command_name.sh"
    command_path="$HOME/cosmos_scripts/$command_file"
    wget -O $command_path "$github_command_url/$command_file"
    chmod +x $command_path
    echo "alias cosmos_$command_name=\"$command_path\"" >> $HOME/$COSMOS_PROFILE_FILE_NAME
done

echo "alias cosmos_logs=\"journalctl -u $COSMOS_SERVICE_NAME -f -o cat\"" >> $HOME/$COSMOS_PROFILE_FILE_NAME && \
echo "alias cosmos_status=\"curl -s $COSMOS_NODE_ADDR/status\"" >> $HOME/$COSMOS_PROFILE_FILE_NAME && \
echo "alias cosmos_consensus=\"curl -s $COSMOS_NODE_ADDR/consensus_state  | jq '.result.round_state.height_vote_set[0].prevotes_bit_array'\"" >> $HOME/$COSMOS_PROFILE_FILE_NAME && \
source $HOME/$COSMOS_PROFILE_FILE_NAME