{ pkgs ? import <nixpkgs> {} }:

pkgs.dockerTools.buildImage {
  name = "nixos-full";
  tag = "latest";

  config = {
    createUser = true;
    user = "sarnobat";
    group = "users";
    uid = 1000;
    shell = "/run/current-system/sw/bin/zsh";
  };

  contents = [
    pkgs.gitFull
    pkgs.autossh
    pkgs.bat
    pkgs.bzip2
    pkgs.grc
    pkgs.inetutils
    pkgs.iproute2
    pkgs.lsof
    pkgs.nettools
    pkgs.nmap
    pkgs.openssh
    pkgs.plocate
    pkgs.psmisc
    pkgs.sudo
    pkgs.vim
    pkgs.wget
    pkgs.zsh
  ];
}
