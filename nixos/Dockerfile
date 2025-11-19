FROM nixos/nix

# Install tools via nix-env.
RUN nix-env -iA \
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

ENV PATH="/root/.nix-profile/bin:${PATH}"

# Optional: set a default shell
SHELL ["/root/.nix-profile/bin/zsh", "-c"]

CMD ["/root/.nix-profile/bin/zsh"]
