FROM ubuntu:24.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential bc bison flex \
    libncurses-dev libelf-dev \
    xz-utils curl wget git \
    gcc-14 g++-14 libssl-dev \
    gcc-x86-64-linux-gnu g++-x86-64-linux-gnu \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# COPY linux-6.12.11-patched.tar.xz /build/
# COPY	config-6.12.11-tinycore64 	/build/

COPY 	Makefile_linux			/build/
COPY	init				/build/

# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]
CMD ["sleep", "infinity"]
