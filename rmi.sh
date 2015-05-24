#!/usr/bin/env bash
./docker ps | grep ssh_rsyslog && ./docker kill `./docker ps | grep ssh_rsyslog | awk '{print $1}'`
./docker images | grep ssh_rsyslog && ./docker rmi -f `./docker images | grep ssh_rsyslog | awk '{print $3}'`
