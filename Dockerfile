# create debian9-salt-master

FROM debian:stretch
MAINTAINER yine <yangxianjun@gmail.com>
ENV TZ "Asia/Shanghai"
ENV LANG en_US.utf8
ENV REFRESHED_AT 2019-11-26

RUN echo 'deb http://httpredir.debian.org/debian stretch-backports main' >> /etc/apt/sources.list \
    && echo 'deb http://httpredir.debian.org/debian stretch main' >> /etc/apt/sources.list

RUN apt-get update && apt-get -y --quiet --force-yes upgrade \
	&& apt-get install -y --quiet --force-yes locales curl wget aptitude sudo make vim cron net-tools \
	&& apt-get install -y --quiet --force-yes git gcc g++ gdb uuid-dev rsyslog gnupg dirmngr telnet \
	&& apt-get install -y --quiet --force-yes salt-master salt-minion \ 
	&& rm -rf /var/lib/apt/lists/*

RUN groupadd -r netease && useradd -r -g netease -m popo && echo 'popo ALL=(ALL) NOPASSWD: ALL'  >> /etc/sudoers

# expose port
EXPOSE 22

# Define default command
CMD ["bash"]

