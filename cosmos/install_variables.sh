touch $HOME/$COSMOS_PROFILE_FILE_NAME && \
install_script_url="https://raw.githubusercontent.com/stasjara/bash-scripts/master/general/insert_variable.sh" && \
bash <(curl -s $install_script_url) \
    -n COSMOS_PROFILE_FILE_NAME -v "$COSMOS_PROFILE_FILE_NAME" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_PROFILE_PATH -v "$COSMOS_PROFILE_PATH" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_MONIKER -v "$COSMOS_MONIKER" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_WALLET -v "$COSMOS_WALLET" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_WEBSITE -v "$COSMOS_WEBSITE" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_IDENTITY -v "$COSMOS_IDENTITY" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_DETAILS -v "$COSMOS_DETAILS" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_SECURITY_CONTACT -v "$COSMOS_SECURITY_CONTACT" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_BINARY -v "$COSMOS_BINARY" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_CHAIN -v "$COSMOS_CHAIN" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_VALOPER -v "$COSMOS_VALOPER" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_WALLET_ADDRESS -v "$COSMOS_WALLET_ADDRESS" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_TOKEN -v "$COSMOS_TOKEN" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_FEE -v "$COSMOS_FEE" -f $COSMOS_PROFILE_FILE_NAME && \    
bash <(curl -s $install_script_url) \
    -n COSMOS_NODE_FOLDER -v "$COSMOS_NODE_FOLDER" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_NODE_PATH -v "$HOME/$COSMOS_NODE_FOLDER" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_NODE_BINARY_URL -v "$COSMOS_NODE_BINARY_URL" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_NODE_REPOSITORY_URL -v "$COSMOS_NODE_REPOSITORY_URL" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_NODE_GIT_BRANCH -v "$COSMOS_NODE_GIT_BRANCH" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_NODE_GIT_TAG -v "$COSMOS_NODE_GIT_TAG" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_PEERS -v "$COSMOS_PEERS" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_SEEDS -v "$COSMOS_SEEDS" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_NODE_ID -v "$COSMOS_NODE_ID" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_NODE_ADDR -v "127.0.0.1:$((COSMOS_NODE_ID+26))657" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_GENESIS_URL -v "$COSMOS_GENESIS_URL" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_ADDRBOOK_URL -v "$COSMOS_ADDRBOOK_URL" -f $COSMOS_PROFILE_FILE_NAME && \
bash <(curl -s $install_script_url) \
    -n COSMOS_SERVICE_NAME -v "$COSMOS_SERVICE_NAME" -f $COSMOS_PROFILE_FILE_NAME && \
sed -i "/$COSMOS_PROFILE_FILE_NAME/d" $HOME/.bash_profile && \
echo "source $HOME/$COSMOS_PROFILE_FILE_NAME" >> $HOME/.bash_profile && \
source "$HOME/$COSMOS_PROFILE_FILE_NAME"