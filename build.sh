#!/usr/bin/env bash
./docker images | grep ssh_rsyslog || ./docker build --rm=true -t ipv1337/ssh_rsyslog:centos7 .
