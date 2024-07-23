# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  unstable,
  inputs,
  ...
}:
let
  windowManager = "sway";
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ./services
  ];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs windowManager;
    };
    users = {
      "sirimhrzn" = import ./home.nix;
    };
  };
  security.polkit.enable = true;
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
    device = "nodev";
  };
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "nixos";
    nameservers = [ ];
  };
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-intel" ];

  # xdg.portal.enable = true;
  xdg.autostart.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  services.greetd = {
    enable = true;
    package = pkgs.greetd.tuigreet;
    settings = rec {
      greetdCommand = "${pkgs.greetd.tuigreet}/bin/tuigreet";
      sway = "${pkgs.sway}/bin/sway";
      hypr = "${pkgs.hyprland}/bin/hyprland";
      default_session = {
        command =
          if windowManager == "sway" then
            "${greetdCommand} --cmd ${sway}"
          else
            "${greetdCommand} --cmd ${hypr}";
      };
    };
  };

  programs.starship = {
    enable = true;
  };

  fonts.packages = [
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "ComicShannsMono"
      ];
    })
  ];
  programs.sway = {
    enable = if windowManager == "sway" then true else false;
    wrapperFeatures.gtk = true;
    package = pkgs.sway;
    extraPackages = with pkgs; [
      rofi
      light
    ];
  };

  programs.zsh.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  programs.light.enable = true;

  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;
  services.xserver = {
    enable = false;
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  services.blueman.enable = true;
  users.groups.sirimhrzn = { };
  users.users.sirimhrzn = {
    isNormalUser = true;
    group = "sirimhrzn";
    description = "sirimhrzn";
    hashedPassword = "$6$gj7wGP2bivbhIQQ3$b22ysKyYOMXlrPh0iRhAUHAhOE2wC1uVrhbBMKdYAnH3wedZfqPP5ho6op8kHFLNed4p3lR47mnoH6ib/sYK31";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
    packages = [
      pkgs.networkmanagerapplet
      pkgs.font-awesome
      pkgs.oh-my-zsh
      pkgs.acpi
      pkgs.yazi
      pkgs.gnome.nautilus
      pkgs.gitui
      pkgs.cargo
      pkgs.bat
      pkgs.nodejs_22
      pkgs.pavucontrol
      pkgs.blueman
      pkgs.bluez
      pkgs.bluez-tools
      pkgs.swappy
      pkgs.grimblast
      pkgs.pamixer
      pkgs.docker
      pkgs.silicon
      pkgs.starship
      pkgs.btop
      pkgs.neofetch
      pkgs.pulseaudio
      pkgs.ngrok
      pkgs.streamlink
      pkgs.zoxide
      pkgs.postman
      pkgs.neovim
      pkgs.virt-manager
      pkgs.virt-viewer
      pkgs.lite-xl
      pkgs.wezterm

      unstable.zed-editor
      unstable.nodePackages.npm
      unstable.go
      unstable.gopls
      unstable.glab
      unstable.vscode
      unstable.alacritty
      unstable.git-cliff
      unstable.delta
      unstable.helix
    ];
  };

  nix.settings.trusted-users = [
    "root"
    "sirimhrzn"
  ];
  users.defaultUserShell = pkgs.zsh;

  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
      9000
    ];
  };

  environment.systemPackages = [
    pkgs.vim
    pkgs.wget
    pkgs.dunst
    pkgs.waybar
    pkgs.swww
    pkgs.polkit_gnome
    pkgs.dolphin
    pkgs.ntfs3g
    pkgs.wl-clipboard
    pkgs.curl
    pkgs.zsh
    pkgs.polybar
    pkgs.rofi
    pkgs.brightnessctl
    pkgs.wofi
    pkgs.fish
    pkgs.git
    pkgs.jq
    pkgs.kubectl
    pkgs.clang
    pkgs.openvpn
    pkgs.ripgrep
    pkgs.openssl.dev
    pkgs.nginx
    pkgs.bun
    pkgs.wrk
    pkgs.lua54Packages.lua
    pkgs.luaformatter
    pkgs.uutils-coreutils-noprefix
    pkgs.go-mtpfs
    pkgs.fd
    pkgs.just
    pkgs.mariadb
    pkgs.podman
    pkgs.gcc
    pkgs.liburing
    pkgs.hyperfine
    pkgs.ffmpeg
    pkgs.zellij
    pkgs.kitty

    unstable.zig
  ];

  services.openssh.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      elasticsearch = {
        image = "elasticsearch:7.17.22";
        autoStart = false;
        environment = {
          "discovery.type" = "single-node";
          "ES_JAVA_OPTS" = "-Xms512m -Xmx512m";
        };
        ports = [ "9200:9200" ];
        volumes = [ "elasticsearch-data:/usr/share/elasticsearch/data" ];
      };
      kibana = {
        image = "kibana:7.17.22";
        autoStart = false;
        environment = {
          "ELASTICSEARCH_HOSTS" = "http://172.17.0.4:9200";
        };
        ports = [ "5601:5601" ];
      };
      pma = {
        image = "postgres:latest";
        ports = [ "5432:5432" ];
        autoStart = false;
        environment = {
          POSTGRES_PASSWORD = "siri";
          POSTGRES_USER = "siri";
          POSTGRES_DB = "backend-my";
        };
      };
    };
  };

  system.stateVersion = "24.05";
}
