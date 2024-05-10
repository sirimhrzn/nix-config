# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  unstable,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "nixos";
    nameservers = [
    ];
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
    pkgs.noto-fonts-cjk
    pkgs.noto-fonts-emoji
    pkgs.liberation_ttf
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.mplus-outline-fonts.githubRelease
    pkgs.dina-font
    pkgs.proggyfonts
    pkgs.noto-fonts-emoji
    (unstable.nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
        "JetBrainsMono"
        "ZedMono"
      ];
    })
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
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };
 services.xserver = {
    enable = true;
    windowManager.bspwm = {
       enable = true;
       package = unstable.bspwm;
       configFile = "/home/sirimhrzn/.config/bspwm/bspwmrc";
       sxhkd = {
       package = unstable.sxhkd;
       configFile = "/home/sirimhrzn/.config/bspwm/sxhkdrc";
       };
    };
    desktopManager.xfce = {
       enableXfwm = false;
    };
   displayManager.lightdm = {
      enable = true;
    };
  };
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
      pkgs.firefox-beta
      pkgs.networkmanagerapplet
      pkgs.font-awesome
      pkgs.nerdfonts
      pkgs.oh-my-zsh
      pkgs.acpi
      # pkgs.gnome.nautilus
      pkgs.gitui
      pkgs.cargo
      pkgs.bat
      pkgs.nodejs_21
      pkgs.pavucontrol
      pkgs.blueman
      pkgs.bluez
      pkgs.bluez-tools
      pkgs.swappy
      pkgs.grimblast
      pkgs.pamixer
      pkgs.discord
      pkgs.docker
      pkgs.silicon
      pkgs.starship
      pkgs.btop
      pkgs.ksnip
      pkgs.neofetch

      pkgs.pulseaudio
      unstable.dmenu-rs

      pkgs.haskellPackages.kmonad
      pkgs.picom
      unstable.zed-editor
      unstable.nix-direnv
      unstable.teams-for-linux
      unstable.zoxide
      unstable.direnv
      unstable.postman
      unstable.brave
      unstable.nodePackages.npm
      unstable.go
      unstable.gopls
      unstable.glab
      unstable.vscode
      unstable.alacritty
      unstable.git-cliff
      unstable.delta
      unstable.neovim
    ];
  };

  nix.settings.trusted-users = [
    "root"
    "sirimhrzn"
  ];
  users.defaultUserShell = pkgs.zsh;
  environment.interactiveShellInit = ''
	alias ls="eza";
  '';

  services.nginx =
    let
      data_dir = "/home/sirimhrzn/Desktop/Genius/news/public";
    in
    {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts.localhost = {
        extraConfig = ''
          add_header x-systemd-nginx yes;
        '';
        locations."/" = {
          root = data_dir;
          extraConfig = ''
            proxy_pass http://localhost:8080;
          '';
        };
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
    pkgs.libnotify
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
    pkgs.fluent-bit
    pkgs.brightnessctl
    pkgs.wofi
    pkgs.fish
    pkgs.git
    pkgs.jq
    pkgs.sddm
    pkgs.kubectl
    pkgs.xclip
    pkgs.clang
    pkgs.rsyslog
    pkgs.openvpn
    pkgs.ripgrep
    pkgs.openssl.dev
    pkgs.eza
    pkgs.nginx
    pkgs.feh
    unstable.kitty
    unstable.zellij
  ];
  services = {
      picom = {
      enable = true;
      settings = {
        animations = true;
        animation-stiffness = 300.0;
        animation-dampening = 35.0;
        animation-clamping = false;
        animation-mass = 1;
        animation-for-workspace-switch-in = "auto";
        animation-for-workspace-switch-out = "auto";
        animation-for-open-window = "slide-down";
        animation-for-menu-window = "none";
        animation-for-transient-window = "slide-down";
        corner-radius = 12;
        rounded-corners-exclude = [
          "class_i = 'polybar'"
          "class_g = 'i3lock'"
        ];
        round-borders = 3;
        round-borders-exclude = [];
        round-borders-rule = [];
        shadow = true;
        shadow-radius = 8;
        shadow-opacity = 0.4;
        shadow-offset-x = -8;
        shadow-offset-y = -8;
        fading = false;
        inactive-opacity = 0.8;
        frame-opacity = 0.7;
        inactive-opacity-override = false;
        active-opacity = 1.0;
        focus-exclude = [
        ];

        opacity-rule = [
          "100:class_g = 'i3lock'"
          "60:class_g = 'Dunst'"
	  "90:class_g = 'Polybar' && !focused"
          "100:class_g = 'Alacritty' && focused"
          "90:class_g = 'Alacritty' && !focused"
          "100:class_g = 'Kitty' && focused"
          "90:class_g = 'Kitty' && !focused"
 
        ];

        blur-kern = "3x3box";
        blur = {
          method = "kernel";
          strength = 8;
          background = false;
          background-frame = false;
          background-fixed = false;
          kern = "3x3box";
        };

        shadow-exclude = [
          "class_g = 'Dunst'"
        ];

        blur-background-exclude = [
          "class_g = 'Dunst'"
        ];

        backend = "glx";
        vsync = false;
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        detect-rounded-corners = true;
        detect-client-opacity = false;
        detect-transient = true;
        detect-client-leader = true;
        use-damage = true;
        log-level = "info";

        wintypes = {
          normal = { fade = true; shadow = false; };
          tooltip = { fade = true; shadow = false; opacity = 0.75; focus = true; full-shadow = false; };
          dock = { shadow = false; };
          dnd = { shadow = false; };
          popup_menu = { opacity = 1.0; };
          dropdown_menu = { opacity = 1.0; };
        };
      };
    };
  }; 
  services.openssh.enable = true;
  services.rsyslogd = {
    enable = true;
    extraConfig = ''
      $ModLoad imtcp
      $InputTCPServerRun 514
      if $programname == 'laravel' then /var/log/laravel.log
      if $programname == 'nginx' then /var/log/nginx.log
    '';
  };
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      nginx =
        let
          dir = "/home/sirimhrzn/nixos-containers/nginx";
        in
        {
          image = "nginx:stable-alpine";
          ports = [ "8080:80" ];
          volumes = [
            "${dir}/nginx.conf:/etc/nginx/nginx.conf"
            "${dir}/conf.d:/etc/nginx/conf.d"
            "${dir}/log:/var/log/nginx"
          ];
          autoStart = true;
        };
    };
  };
  system.stateVersion = "23.11";
}
