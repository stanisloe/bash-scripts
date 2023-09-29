$COSMOS_BINARY tx staking edit-validator \
--new-moniker="$COSMOS_MONIKER" \
--website="$COSMOS_WEBSITE" \
--details="$COSMOS_DETAILS" \
--security-contact="$COSMOS_SECURITY_CONTACT" \
--identity="$COSMOS_IDENTITY" \
--from=$COSMOS_WALLET \
--fees $COSMOS_FEE$COSMOS_TOKEN \
-y