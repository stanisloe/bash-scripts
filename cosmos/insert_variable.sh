name=$1
value=$2

if [ ! -n "$name" ]; then
    echo "Enter the name:"
    read -r name
fi
if [ ! -n "$value" ]; then
    echo "Enter the value:"
    read -r value
fi

if ! cat $HOME/$COSMOS_VARIABLES_PROFILE | grep -q " ${name}="; then
    echo "export ${name}=\"${value}\"" >> $HOME/$COSMOS_VARIABLES_PROFILE
elif ! cat $HOME/$COSMOS_VARIABLES_PROFILE | grep -qF "${name}=\"${value}\""; then
    sed -i "s%^.*${name}*=.*%export ${name}=\"${value}\"%" $HOME/$COSMOS_VARIABLES_PROFILE
fi

. $HOME/.bash_profile