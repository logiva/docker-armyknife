#!/bin/bash

PW=$(pwgen --secure --numerals 16 1)
echo "root:$PW" | chpasswd
sed -i 's/#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
mkdir /var/run/sshd

jq --arg p "$PW" '{sshuser:"root", sshpassword:$p}' <<< '{}' > /var/run/sshinfo 

echo "Starting sshd, check /var/run/sshinfo for ssh info" 1>&2

exec /usr/sbin/sshd -D
