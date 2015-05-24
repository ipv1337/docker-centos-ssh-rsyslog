#
# http://www.projectatomic.io/docs/docker-image-author-guidance/
# http://www.projectatomic.io/blog/2014/09/running-syslog-within-a-docker-container/
#

FROM centos:centos7
MAINTAINER James H Nguyen <james@callfire.com>

RUN yum -y update && yum clean all
RUN yum -y install openssh-server passwd sudo rsyslog && yum clean all
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum clean all

# Dockumentation
ADD ./Dockerfile /root/Dockerfile
ADD ./README.md /root/README.md

# Network
RUN echo 'HOSTNAME=docker' >>/etc/sysconfig/network

# rsyslogd
ADD elk.conf /etc/rsyslog.d/elk.conf
RUN sed -i 's/^\$ModLoad imjournal/#\$ModLoad imjournal/' /etc/rsyslog.conf
RUN sed -i 's/^\$OmitLocalLogging on/\$OmitLocalLogging off/' /etc/rsyslog.conf
RUN sed -i 's/^\$IMJournalStateFile imjournal.state/#\$IMJournalStateFile imjournal.state/' /etc/rsyslog.conf
RUN sed -i 's/^\$SystemLogSocketName/#\$SystemLogSocketName/' /etc/rsyslog.d/listen.conf

# sshd
ADD docker_id_rsa.pub /var/preserve/id_rsa.pub
RUN mkdir /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
RUN echo '%wheel	ALL=NOPASSWD: ALL' >>/etc/sudoers

# init
RUN mkdir -p /opt/bin
RUN mkdir -p /opt/run
ADD init.sh /opt/bin/init.sh
ADD 00_rsyslogd /opt/run/00_rsyslogd
ADD 01_sshd /opt/run/01_sshd
RUN chmod 755 /opt/bin/*
RUN chmod 755 /opt/run/*

ENTRYPOINT ["/opt/bin/init.sh"]
