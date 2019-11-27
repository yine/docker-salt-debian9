# create debian9-salt-master

FROM debian:stretch
MAINTAINER yine <yangxianjun@gmail.com>
ENV TZ "Asia/Shanghai"
ENV LANG en_US.utf8
ENV REFRESHED_AT 2019-11-26

RUN echo "deb http://mirrors.163.com/debian/ stretch main non-free contrib"  >>/etc/apt/sources.list \
	&& echo "deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib"  >>/etc/apt/sources.list \
	&& echo "deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib"  >>/etc/apt/sources.list \
	&& echo "deb-src http://mirrors.163.com/debian/ stretch main non-free contrib"  >>/etc/apt/sources.list \
	&& echo "deb-src http://mirrors.163.com/debian/ stretch-updates main non-free contrib"  >>/etc/apt/sources.list \
	&& echo "deb-src http://mirrors.163.com/debian/ stretch-backports main non-free contrib"  >>/etc/apt/sources.list \
	&& echo "deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib"  >>/etc/apt/sources.list \
	&& echo "deb-src http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib"  >>/etc/apt/sources.list \
	&& echo 'deb http://httpredir.debian.org/debian stretch-backports main' >> /etc/apt/sources.list \
    && echo 'deb http://httpredir.debian.org/debian stretch main' >> /etc/apt/sources.list

RUN apt-get update && apt-get -y --quiet --force-yes upgrade \
	&& apt-get install -y --quiet --force-yes locales curl wget aptitude sudo make vim cron net-tools \
	&& apt-get install -y --quiet --force-yes git gcc g++ gdb uuid-dev rsyslog gnupg dirmngr telnet \
	&& apt-get install -y --quiet --force-yes salt-master salt-minion procps openssh-server \ 
	&& rm -rf /var/lib/apt/lists/*

RUN groupadd -r netease && useradd -r -g netease -m popo && echo 'popo ALL=(ALL) NOPASSWD: ALL'  >> /etc/sudoers
RUN mkdir -p /var/run/sshd && ln -s /etc/salt/.ssh ~/.ssh 

RUN echo "/usr/sbin/sshd -D" > ~/run.sh && echo "/usr/bin/salt-master -d" >> ~/run.sh
RUN chmod 744 ~/run.sh

# expose port
EXPOSE 22 4505 4506

# Define default command /usr/sbin/sshd -D /usr/bin/salt-master -d
CMD ["sh", "-c", "~/run.sh"]
