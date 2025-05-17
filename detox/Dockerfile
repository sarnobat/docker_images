#FROM alpine
FROM ubuntu:22.04
CMD ["echo", "Hello StackOverflow!"]



COPY detox /proj

WORKDIR /proj/

RUN apt update
RUN apt install -y wget
RUN apt install -y autoconf
RUN apt install -y build-essential
RUN apt install -y gcc
RUN apt install -y libncurses5-dev
RUN apt install -y libpcre3-dev
RUN apt install -y autoconf 
RUN apt install -y automake 
RUN apt install -y bison 
RUN apt install -y flex 
RUN apt install -y gcc 
RUN apt install -y make 
RUN apt install -y pkg-config
RUN wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess'
RUN wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub'
# RUN ./configure x86_64
RUN autoreconf --install
RUN ./configure arm64 --with-coverage
RUN make
RUN WITH_COVERAGE=1 make install
RUN touch "ubarak-[7249661751770303746].mp4"
# RUN cat INSTALL | /usr/local/bin/detox
