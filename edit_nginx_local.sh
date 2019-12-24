#!/bin/bash
. /etc/profile
set -x
set -e

# Edit the pillar file
vim /etc/ansible/group_vars/nginx/nginx.yml
pushd /etc/ansible; git commit -am 'updated nginx rules'; popd

# Update the Let's Encrypt certificates
./roles/nginx/scripts/cert-scrub.py

# run the nginx playbook
ansible-playbook nginxlocal.yml
pushd /etc/nginx; ./deploy.sh; popd
