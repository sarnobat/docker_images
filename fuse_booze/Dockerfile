FROM ubuntu:24.04
# you’re telling APT not to ask any questions during installs (like timezone selection, service restarts, or confirmation prompts).
ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get update


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

#     apt-get source bash && \
#     cp -r bash-*/builtins /usr/include/bash-builtins && \
#     cp -r bash-*/include /usr/include/bash-include && \
#     rm -rf bash-*

RUN cd /usr/local/include && apt-get source bash \
        && ln -s bash-5.2.21 bash && cd bash && ./configure && make
        # && cp -r bash-*/builtins /usr/include/bash-builtins \
        # && cp -r bash-*/include /usr/include/bash-include \
# RUN cp -r /bash-5.2.21 /usr/include/bash-full
# RUN cp -r /bash-5.2.21 /root/bash-5.2.21

COPY booze/ /root/booze/

ENV PKG_CONFIG_PATH=/usr/local/include/bash-5.2.21/support/:/root/bash-5.2.21:/root/bash-5.2.21/support:/usr/lib/aarch64-linux-gnu/pkgconfig:/usr/share/pkgconfig:/bash-5.2.21:/bash-5.2.21/support


# RUN cd /root/booze && make 










# CFLAGS="$CFLAGS -D_FILE_OFFSET_BITS=64 -I/usr/include/bash-include -I/usr/include/bash-builtins -I/root/bash-5.2.21         -I/root/bash-5.2.21/include  -I/root/bash-5.2.21/builtins "
# RUN cd /root/booze && \
#         gcc -Wall -O2 -fPIC -shared booze.c \
#         -I/root/bash-5.2.21 \
#         -I/root/bash-5.2.21/include \
#         -I/root/bash-5.2.21/builtins \
#         -D_FILE_OFFSET_BITS=64 \
#         -lfuse \
#         -o booze.so

CMD ["tail", "-f", "/dev/null"]
