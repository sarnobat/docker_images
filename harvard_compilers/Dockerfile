FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/zsh
ENV TERM=xterm-256color

ENV ZDOTDIR=/tmp/
COPY .zshrc /tmp/.zshrc

RUN apt update

RUN apt install -y autossh
RUN apt install -y bat
RUN apt install -y bzip2
RUN apt install -y git
RUN apt install -y grc
RUN apt install -y inetutils-ping
RUN apt install -y iproute2
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
RUN apt install -y flex bison gcc make pkg-config libfl-dev libbison-dev


RUN ln -sr /media/sarnobat/git/computers.git ~/computers.git
RUN cd /root/ && ln -sr /media/sarnobat/git/computers.git/2022/docker/.zshrc
RUN ln -sr /media/sarnobat/git/computers.git/dotfiles_and_scripts/.dir_colors ~/
RUN ln -sr /media/sarnobat/git/computers.git/mac/git/mac/.gitconfig ~/
RUN ln -srf /media/sarnobat/git/computers.git ~/


RUN useradd -rm -d /home/sarnobat -s /bin/bash -g root -G sudo -u 1000 sarnobat
RUN echo 'sarnobat	ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN  echo 'sarnobat:sarnobat' | chpasswd

USER sarnobat
COPY .zshrc /home/sarnobat/

COPY e95-src.git /home/sarnobat/e95-src.git
RUN sudo chown sarnobat -Rv /home/sarnobat/e95-src.git

# I couldn't get this working on Ubuntu docker. It does work on Mac OS
# RUN cd /home/sarnobat/e95-src.git/src/compiler && make clean && make && ./compiler mips/input/debug.txt



RUN ln -sr /media/sarnobat/git/computers.git ~/


