# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, nixpkgs-unstable ,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix 
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  networking = {
      hostName = "nixos";
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-intel" ];

programs.starship = {
   enable = true;
};
fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
  noto-fonts-emoji
  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono"]; })
];

programs.zsh.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
};

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware = {
	opengl.enable = true;
	nvidia.modesetting.enable = true;
};
  programs.hyprland = {
  	enable = true;
  	xwayland.enable = true;
  };

   services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  displayManager.gdm = {
	enable = true;
        wayland = true;
	};
  };

  xdg.portal.enable = true;
  xdg.autostart.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal xdg-desktop-portal-gtk];

  users.users.sirimhrzn = {
    isNormalUser = true;
    description = "sirimhrzn";
    hashedPassword = "$6$gj7wGP2bivbhIQQ3$b22ysKyYOMXlrPh0iRhAUHAhOE2wC1uVrhbBMKdYAnH3wedZfqPP5ho6op8kHFLNed4p3lR47mnoH6ib/sYK31";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd"];
    packages = [
    pkgs.firefox-wayland
    pkgs.brave
    pkgs.zellij
    pkgs.networkmanagerapplet
    pkgs.openvpn
    pkgs.font-awesome
    pkgs.nerdfonts
    pkgs.oh-my-zsh
    pkgs.neovim
    pkgs.acpi
    pkgs.gnome.nautilus
    pkgs.gitui
    pkgs.cargo 
    pkgs.bat 
    pkgs.nodejs_21
    pkgs.nodePackages.npm
    pkgs.pavucontrol
    pkgs.blueman
    pkgs.bluez
    pkgs.bluez-tools
    pkgs.swappy
    pkgs.grimblast
    pkgs.ripgrep
    pkgs.pamixer
    pkgs.discord
    pkgs.docker
    pkgs.polybar
    pkgs.perl
    pkgs.ranger
    pkgs.xclip
    pkgs.silicon
    pkgs.starship
    pkgs.feh
    pkgs.btop
    pkgs.neofetch
    nixpkgs-unstable.postman
    nixpkgs-unstable.helix
    nixpkgs-unstable.qutebrowser
    nixpkgs-unstable.vscode
    nixpkgs-unstable.alacritty
    nixpkgs-unstable.gleam
    nixpkgs-unstable.git-cliff
    nixpkgs-unstable.diff-so-fancy
    nixpkgs-unstable.wezterm
    nixpkgs-unstable.bun
    ];
  };
  programs.direnv = {
    enable = false;
  };
  nix.settings.trusted-users = [ "root" "sirimhrzn" ];
  # programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
#   users.users.sirimhrzn.openssh.authorizedKeys.keys = [
# ];
#
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    pkgs.wget
    pkgs.dunst
    pkgs.libnotify
    pkgs.waybar
    pkgs.swww
    pkgs.kitty
    pkgs.polkit_gnome
    pkgs.dolphin
    pkgs.ntfs3g
    pkgs.wl-clipboard
    pkgs.curl
    pkgs.zsh
    pkgs.brightnessctl
    pkgs.wofi
    pkgs.fish
    pkgs.git
    pkgs.jq
    pkgs.sddm
    pkgs.kubectl
    pkgs.xclip
    pkgs.glib
    pkgs.glibc
    pkgs.gcc
    pkgs.pkg-config
    pkgs.clang
    pkgs.llvmPackages_16.bintools
    pkgs.llvmPackages_16.stdenv
    pkgs.libiconv
    pkgs.openssl.dev
    nixpkgs-unstable.rust-script
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  system.stateVersion = "23.11";

}
