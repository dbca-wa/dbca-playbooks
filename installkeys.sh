#!/bin/bash
# Usage - ./installkeys.sh azadmin@az-k3s-oim01.lan.fyi
# Will install root ssh key, add to ansible, deploy default packages and enable snmp
ssh-copy-id -i ~/.ssh/id_rsa -o PreferredAuthentications=password $1
ssh -i ~/.ssh/id_rsa $1 -t sudo cp -v .ssh/authorized_keys /root/.ssh/authorized_keys
IFS=@; read -a userhost <<<"$1"
grep ${userhost[1]} /etc/ansible/hosts || echo ${userhost[1]} >> /etc/ansible/hosts
ansible-playbook linux.yml

