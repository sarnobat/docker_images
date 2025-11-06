#FROM alpine
FROM ubuntu:22.04
CMD ["echo", "Hello StackOverflow!"]



COPY ccze /proj

WORKDIR /proj/

RUN apt update
RUN apt install -y wget
RUN apt install -y autoconf
RUN apt install -y build-essential
RUN apt install -y gcc
RUN apt install -y libncurses5-dev
RUN apt install -y libpcre3-dev

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
RUN wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess'
RUN wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub'
RUN ./configure x86_64
RUN make
RUN make install
# RUN cat INSTALL | /usr/local/bin/ccze
