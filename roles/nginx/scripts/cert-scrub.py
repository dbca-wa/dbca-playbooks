#!/usr/bin/env python
import yaml

from collections import Counter
import itertools
import json
import os
import subprocess
import sys


NGINX_SERVERS = '/etc/ansible/group_vars/nginx/nginx.yml'
NGINX_SSL = '/etc/ansible/group_vars/nginx/ssl.yml'

CERT_PATH = '/etc/letsencrypt/live'

f = open(NGINX_SERVERS, 'r')
nginx = yaml.load(f)

domains = nginx['nginx_servers'].keys()
domains.sort()

cert_suffixes = [x for x in os.listdir(CERT_PATH) if os.path.isdir(os.path.join(CERT_PATH, x))]

y_output = {'nginx_ssl': {}}
for d in domains:
    for suffix in cert_suffixes:
        if d.endswith('.{}'.format(suffix)):
            y_output['nginx_ssl'][d] = suffix
            break
    if d not in y_output['nginx_ssl']:
       print('Missed domain: {}'.format(d))
yaml.dump(y_output, open(NGINX_SSL, 'w'))

