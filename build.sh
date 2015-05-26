#!/usr/bin/env bash
./docker images | grep rsyslog || ./docker build --rm=true -t ipv1337/rsyslog:centos7 .
