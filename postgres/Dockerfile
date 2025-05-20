#FROM alpine
FROM ubuntu:22.04
CMD ["echo", "Hello StackOverflow!"]



COPY postgres /proj

WORKDIR /proj/

RUN apt update
RUN apt install -y autoconf
RUN apt install -y automake 
RUN apt install -y bison 
RUN apt install -y build-essential
RUN apt install -y flex
RUN apt install -y gcc
RUN apt install -y gcc 
RUN apt install -y libicu-dev
RUN apt install -y libncurses5-dev
RUN apt install -y libpcre3-dev
RUN apt install -y libreadline6-dev
RUN apt install -y make
RUN apt install -y pkg-config
RUN apt install -y python3 ninja-build meson
RUN apt install -y wget
RUN apt install -y zlib1g-dev

RUN apt install -y bat
RUN apt install -y psmisc
RUN apt install -y zsh

RUN wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess'
RUN wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub'
# RUN ./configure x86_64
# RUN autoreconf --install
RUN ./configure
RUN make
RUN WITH_COVERAGE=1 make install
RUN mkdir -p /usr/local/pgsql/data
RUN useradd -m -s /bin/bash pguser


# RUN rehash
RUN ls "/usr/local/pgsql/bin/pg_ctl"
# RUN which pg_ctl
#pg_ctl -D /usr/local/pgsql/data -l logfile start
# RUN make check


# These won't do anything
# RUN export PATH=/usr/local/pgsql/bin/:$PATH
# RUN echo $PATH

RUN chown pguser -Rv /usr/local/pgsql/data
RUN chown pguser -Rv /usr/local/

RUN chown pguser -Rv .

USER pguser
ENV PATH=/usr/local/pgsql/bin/:/usr/local/bin/:$PATH

# doesn't work
# At each stage of the Dockerfile build, a new container is created so any change you make to the user will not persist on the next build stage.
# RUN su pguser - /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start
# no debugging info

# RUN initdb -D /usr/local/pgsql/data
# RUN /usr/local/pgsql/bin/pg_ctl --help
# RUN echo "initdb  --debug -D /usr/local/pgsql/data && /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start && createuser -s -d -r postgres && psql -U postgres -c '\dt *.*'"  


# RUN touch "ubarak-[7249661751770303746].mp4"
# RUN cat INSTALL | /usr/local/bin/postgres

# RUN pg_ctl status -D /usr/local/pgsql/data
# RUN psql -U pgsql

# RUN createuser -s -d -r postgres
# RUN psql -U postgres
# COPY ./docker-entrypoint.sh /proj/
# COPY ./docker-entrypoint.sh /usr/local/bin/
# COPY ./docker-entrypoint.sh /usr/bin/
# WORKDIR /
RUN echo $PATH
ENTRYPOINT ["docker-entrypoint.sh"]