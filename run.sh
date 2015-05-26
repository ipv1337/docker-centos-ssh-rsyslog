#!/usr/bin/env bash

RUN_PARAM=${1}

./rmi.sh
./build.sh
./docker run --name rsyslog -d ipv1337/rsyslog:centos7 $RUN_PARAM
