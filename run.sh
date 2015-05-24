#!/usr/bin/env bash
./rmi.sh
./build.sh
./docker run -d -p 2222:22 ipv1337/ssh_rsyslog:centos7
