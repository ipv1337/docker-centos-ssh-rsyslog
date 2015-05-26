#
# http://www.projectatomic.io/docs/docker-image-author-guidance/
# http://www.projectatomic.io/blog/2014/09/running-syslog-within-a-docker-container/
#

FROM centos:centos7
MAINTAINER James H Nguyen <james@callfire.com>

RUN yum -y update && yum clean all
RUN yum -y install rsyslog && yum clean all

# Network
RUN echo 'HOSTNAME=docker' >>/etc/sysconfig/network

# rsyslogd
ADD rsyslog.d/remote.conf /etc/rsyslog.d/remote.conf
RUN sed -i 's/^\$ModLoad imjournal/#\$ModLoad imjournal/' /etc/rsyslog.conf
RUN sed -i 's/^\$OmitLocalLogging on/\$OmitLocalLogging off/' /etc/rsyslog.conf
RUN sed -i 's/^\$IMJournalStateFile imjournal.state/#\$IMJournalStateFile imjournal.state/' /etc/rsyslog.conf
RUN sed -i 's/^\$SystemLogSocketName/#\$SystemLogSocketName/' /etc/rsyslog.d/listen.conf
RUN mkdir -p /var/spool/rsyslog

# init
RUN mkdir -p /opt/bin
RUN mkdir -p /opt/run
ADD init/init.sh /opt/bin/init.sh
ADD init/00_rsyslogd /opt/run/00_rsyslogd
RUN chmod 755 /opt/bin/*
RUN chmod 755 /opt/run/*

ENTRYPOINT ["/opt/bin/init.sh"]
CMD ["--help"]
