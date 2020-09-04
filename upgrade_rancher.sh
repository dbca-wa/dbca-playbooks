#!/bin/bash
CONTAINER=$(docker ps | grep -e rancher -e 80 -e 443 | awk '{print $1}')
TAG="v2.4.8"
docker stop $CONTAINER
# Below only required if rancher-data container has never been created
# docker create --volumes-from $CONTAINER --name rancher-data rancher/rancher:latest
docker pull rancher/rancher:$TAG
docker run -d --volumes-from rancher-data --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:$TAG
# Remove all exited containers
docker rm $(docker ps -qa --filter status=exited)

