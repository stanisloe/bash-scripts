name=$1
value=$2
type="export"
profile_file=".bash_profile"

option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-n*|--name*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		name=`option_value "$1"`
		shift
		;;
	-v*|--value*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		value=`option_value "$1"`
		shift
		;;
    -f*|--file*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		profile_file=`option_value "$1"`
		shift
		;;
	-a|--alias)
		type="alias"
		shift
		;;
	*|--)
		break
		;;
	esac
done

if ! cat $HOME/$profile_file | grep -q "${type} ${name}="; then
	echo "${type} ${name}=\"${value}\"" >> $HOME/$profile_file
else
	sed -i "s%^${type} ${name}=.*%${type} ${name}=\"${value}\"%" $HOME/$profile_file
fi

source $HOME/$profile_file