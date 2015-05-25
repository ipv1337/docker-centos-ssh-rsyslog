#!/usr/bin/env bash

RUN_PARAM=${1}

./rmi.sh
./build.sh
./docker run --name ssh_rsyslog -d -p 2222:22 ipv1337/ssh_rsyslog:centos7 $RUN_PARAM
