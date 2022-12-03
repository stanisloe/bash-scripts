#!/usr/bin/env bash

USER_NAME=$1

if [ -z "$USER_NAME" ];
then 
    echo "User name was not provided. Enter user name now:";
    read USER_NAME
fi

adduser $USER_NAME
echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR="tee -a" visudo

echo "AllowUsers $USER_NAME" >> /etc/ssh/sshd_config

systemctl restart ssh.service