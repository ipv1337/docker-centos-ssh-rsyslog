# dockerfiles-centos-ssh-rsyslog

# Building & Running

Copy the sources to your docker host and build the container:

	# docker build --rm=true -t <username>/ssh_rsyslog:centos7 .

To run:

	# docker run -d -p 2222:22 <username>/ssh_rsyslog:centos7

Configure ssh config:

```
cat ssh/config >>~/.ssh/config
cp ssh/docker_id_rsa* ~/.ssh
```

To test, simply run:

	# ssh docker 

Or run:

	# docker exec -it ssh_rsyslog logger 'sample log message'
