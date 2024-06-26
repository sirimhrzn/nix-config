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
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ./services
  ];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      "sirimhrzn" = import ./home.nix;
    };
  };
  security.polkit.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
    device = "nodev";
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

  programs.starship = {
    enable = true;
  };
  fonts.packages = [
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.zsh.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  programs.light.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
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
    enable = true;
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
      pkgs.vlc
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

      unstable.nodePackages.npm
      unstable.go
      unstable.gopls
      unstable.glab
      unstable.vscode
      unstable.alacritty
      unstable.wezterm
      unstable.git-cliff
      unstable.delta
      unstable.helix
      unstable.zed-editor
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
      5432
      6443
      10250
      2379
      2380
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
    unstable.kitty
    unstable.zellij
  ];
  services.openssh.enable = true;
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      pma = {
        image = "postgres:latest";
        ports = [ "5432:5432" ];
        autoStart = true;
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
