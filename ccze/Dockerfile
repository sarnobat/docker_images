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
RUN wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess'
RUN wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub'
RUN ./configure x86_64
RUN make
RUN make install
# RUN find | /usr/local/bin/ccze