CRON_EXPRESSION=$1
CRON_COMMAND=$2

if [ -z "$CRON_EXPRESSION" ];
then 
    echo "Cron expression was not provided. Enter it now:";
    read CRON_EXPRESSION
fi

if [ -z "$CRON_COMMAND" ];
then 
    echo "Cron command was not provided. Enter it now:";
    read CRON_COMMAND
fi

crontab -u $(whoami) -l; echo "$CRON_EXPRESSION bash -c 'source /home/$(whoami)/.bash_profile; $CRON_COMMAND'" | crontab -u $(whoami) -