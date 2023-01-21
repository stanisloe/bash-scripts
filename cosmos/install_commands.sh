rm -rf $HOME/cosmos_scripts
mkdir $HOME/cosmos_scripts

github_command_url="https://raw.githubusercontent.com/stasjara/bash-scripts/master/cosmos/commands/"
declare -a command_names=(
    gov_vote
    restart
    self_delegate
)
for command_name in "${command_names[@]}"
do
    command_file="$command_name.sh"
    command_path="$HOME/cosmos_scripts/$command_file"
    wget -O $command_path "$github_command_url/$command_file"
    chmod +x $command_path
    bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/general/insert_variable.sh) \
        -a -n cosmos_$command_name -v "$command_path" -f $COSMOS_PROFILE_FILE_NAME
done

bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/general/insert_variable.sh) \
    -a -n cosmos_logs -v "journalctl -u $COSMOS_SERVICE_NAME -f -o cat" -f $COSMOS_PROFILE_FILE_NAME
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/general/insert_variable.sh) \
    -a -n cosmos_status -v "curl -s $COSMOS_NODE_ADDR/status" -f $COSMOS_PROFILE_FILE_NAME
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/general/insert_variable.sh) \
    -a -n cosmos_consensus -v "curl -s $COSMOS_NODE_ADDR/consensus_state  | jq '.result.round_state.height_vote_set[0].prevotes_bit_array'" -f $COSMOS_PROFILE_FILE_NAME
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/general/insert_variable.sh) \
    -a -n cosmos_balance -v "$COSMOS_BINARY q bank balances $COSMOS_WALLET_ADDRESS" -f $COSMOS_PROFILE_FILE_NAME
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/general/insert_variable.sh) \
    -a -n cosmos_unjail -v "$COSMOS_BINARY tx slashing unjail --from $COSMOS_WALLET --fees 5000$COSMOS_TOKEN -y" -f $COSMOS_PROFILE_FILE_NAME
bash <(curl -s https://raw.githubusercontent.com/stasjara/bash-scripts/master/general/insert_variable.sh) \
    -a -n disable_sync -v "sed -i -e \"s|^enable *=.*|enable = true|\" $HOME/$COSMOS_NODE_FOLDER/config/config.toml" -f $COSMOS_PROFILE_FILE_NAME
source $HOME/$COSMOS_PROFILE_FILE_NAME