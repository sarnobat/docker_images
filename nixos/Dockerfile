FROM ghcr.io/nixos/nix:latest

# Install packages inside the container using Nix
RUN nix-env -iA \
    nixpkgs.gitFull \
    nixpkgs.autossh \
    nixpkgs.bat \
    nixpkgs.bzip2 \
    nixpkgs.grc \
    nixpkgs.inetutils \
    nixpkgs.iproute2 \
    nixpkgs.lsof \
    nixpkgs.nettools \
    nixpkgs.nmap \
    nixpkgs.openssh \
    nixpkgs.plocate \
    nixpkgs.psmisc \
    nixpkgs.sudo \
    nixpkgs.vim \
    nixpkgs.wget \
    nixpkgs.zsh

# Add Nix profile binaries to PATH
ENV PATH="/root/.nix-profile/bin:${PATH}"

# Install shadow utilities so we can add a user
RUN nix-env -iA nixpkgs.shadow

# Create a non-root user
RUN echo "sarnobat:x:1000:1000:sarnobat:/home/sarnobat:/root/.nix-profile/bin/zsh" >> /etc/passwd \
    && echo "sarnobat:x:1000:" >> /etc/group \
    && mkdir -p /home/sarnobat

# Give sudo to the user
RUN echo "sarnobat ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER sarnobat
WORKDIR /home/sarnobat

CMD ["zsh"]
