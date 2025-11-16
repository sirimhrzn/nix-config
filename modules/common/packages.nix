{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) optionals;
in {
  environment.systemPackages = [
    pkgs.cowsay
    pkgs.eza
    pkgs.git
    pkgs.curl
    pkgs.dig
    pkgs.lsd
    pkgs.fastfetch
    pkgs.fd
    pkgs.hyperfine
    pkgs.jc
    pkgs.moreutils
    pkgs.openssl
    pkgs.p7zip
    pkgs.pstree
    pkgs.rsync
    pkgs.sd
    pkgs.timg
    pkgs.tokei
    pkgs.typos
    pkgs.uutils-coreutils-noprefix
    pkgs.xh
    pkgs.yazi
    pkgs.yt-dlp
    (pkgs.fortune.override {withOffensive = true;})
    pkgs.netbird
    pkgs.vim
    pkgs.alejandra
    pkgs.helix
    pkgs.bat
    pkgs.jujutsu
    pkgs.kubectl
    pkgs.k9s
    pkgs.inetutils
    pkgs.ffmpeg

    pkgs.podman
    pkgs.podman-compose
    pkgs.mariadb
    pkgs.rage
  ];
}
