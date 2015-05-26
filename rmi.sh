#!/usr/bin/env bash
./docker ps | grep rsyslog && ./docker kill `./docker ps | grep rsyslog | awk '{print $1}'`
./docker images | grep rsyslog && ./docker rmi -f `./docker images | grep rsyslog | awk '{print $3}'`
