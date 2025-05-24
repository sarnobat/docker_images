FROM ubuntu:22.04


RUN apt update

RUN apt install -y autossh
RUN apt install -y bat
RUN apt install -y inetutils-ping
RUN apt install -y lsof
RUN apt install -y net-tools
RUN apt install -y nmap
RUN apt install -y openssh-server
RUN apt install -y plocate
RUN apt install -y psmisc # pstree
RUN apt install -y sudo
RUN apt install -y vim
RUN apt install -y wget
RUN apt install -y zsh

RUN useradd -rm -d /home/sarnobat -s /bin/zsh -g root -G sudo -u 1000 sarnobat
RUN echo 'sarnobat	ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN  echo 'sarnobat:sarnobat' | chpasswd
RUN ssh-keygen -A


ENV DEBIAN_FRONTEND=noninteractive
# ENV SHELL=/bin/zsh
ENV TERM=xterm-256color
ENV ZDOTDIR=/tmp/
COPY .zshrc /tmp/.zshrc

RUN touch /tmp/sshd.log && chmod 666 /tmp/sshd.log
# COPY .zshrc /home/sarnobat/

# THIS PART WILL BE REPLACED IF YOU PASS SOME OTHER COMMAND TO docker RUN
RUN service ssh start

# this doesn't do anything if you are using host network.
EXPOSE 22

CMD ["/usr/sbin/sshd","-d","-D", "-E", "/tmp/sshd.log"]

