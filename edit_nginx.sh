#!/bin/bash
. /etc/profile
set -x
set -e

# Edit the pillar file
vim /etc/ansible/group_vars/nginx/nginx.yml
pushd /etc/ansible; git commit -am 'updated nginx rules'; popd
pushd /export/kube-config-backup/ansible_backup; git pull; chmod -R o+rX .; popd

# Update the Let's Encrypt certificates
./roles/nginx/scripts/cert-scrub.py

# run the nginx playbook
ansible-playbook nginx.yml
if [[ $? -eq 0 ]]; then
    /srv/data-harvester/archive_nginx.sh
    /srv/data-harvester-uat/archive_nginx.sh
fi


