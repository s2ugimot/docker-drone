FROM phusion/baseimage:0.9.15

MAINTAINER Shu Sugimoto "shu@su.gimo.to"

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive


# apt-get update
#RUN apt-get update

# install
#RUN apt-get -y --no-install-recommends install docker.io

# cleanup apt cache
#RUN apt-get clean all
#RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN curl -O http://downloads.drone.io/master/drone.deb
RUN dpkg -i drone.deb
RUN rm drone.deb

RUN rm -Rf /etc/service/sshd
RUN rm -Rf /etc/service/cron
RUN rm -Rf /etc/service/syslog-ng
ADD service /etc/service/
RUN chmod +x /etc/service/**/run

RUN rm /etc/my_init.d/00_regen_ssh_host_keys.sh
ADD my_init.d/*.sh /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*.sh
