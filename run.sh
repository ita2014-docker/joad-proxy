#!/bin/sh

: ${NGINX_USER:=daemon}

### Configuration for Docker
if [ -e /var/run/docker.sock ]; then
    docker_group_name=$(stat -c %G /var/run/docker.sock)
    if [ "$docker_group_name" = "UNKNOWN" ]; then
        docker_group_id=$(stat -c %g /var/run/docker.sock)
        docker_group_name=docker
        groupadd -g $docker_group_id $docker_group_name
    fi
    gpasswd -a $NGINX_USER $docker_group_name
fi

/usr/local/nginx/sbin/nginx
