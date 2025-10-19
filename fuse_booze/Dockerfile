FROM ubuntu:24.04
# you’re telling APT not to ask any questions during installs (like timezone selection, service restarts, or confirmation prompts).
ENV DEBIAN_FRONTEND=noninteractive

RUN echo "deb-src http://archive.ubuntu.com/ubuntu noble main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu noble-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu noble-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get update 

RUN apt-get install -y \
        bindfs \
        nfs-ganesha nfs-ganesha-vfs \
        rpcbind \
        systemd-sysv \
        dbus \
        build-essential \
        net-tools iproute2 procps psmisc vim less \
        lsof

RUN apt-get install -y \
        fuse libfuse-dev \
        libreadline-dev \
        bash \
        build-essential \
        pkg-config

RUN apt-get install -y \
        libfuse2 

RUN cd /usr/local/include && apt-get source bash \
        && ln -s bash-5.2.21 bash && cd bash && ./configure && make

COPY booze/ /root/booze/

ENV PKG_CONFIG_PATH=/usr/local/include/bash-5.2.21/support/:/root/bash-5.2.21:/root/bash-5.2.21/support:/usr/lib/aarch64-linux-gnu/pkgconfig:/usr/share/pkgconfig:/bash-5.2.21:/bash-5.2.21/support
ENV LD_LIBRARY_PATH=/usr/local/include/bash-5.2.21/lib/:/usr/lib/aarch64-linux-gnu/

# You also need: CFLAGS += -Wl,--no-as-needed /usr/lib/aarch64-linux-gnu/libfuse.so -Wl,--as-needed  -D_FILE_OFFSET_BITS=64 -pthread -Wl,-rpath,/usr/lib/aarch64-linux-gnu
RUN cd /root/booze && make clean && make --always-make

CMD ["tail", "-f", "/dev/null"]
