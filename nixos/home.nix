{
  config,
  lib,
  pkgs,
  ...
}:
let
  smod = config.wayland.windowManager.sway.config.modifier;
in
{
  home.username = "sirimhrzn";
  home.homeDirectory = "/home/sirimhrzn";

  home.packages = [ pkgs.kitty-themes ];
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
    # font.name = "FiraCode Nerd Font";
    theme = "Tomorrow Night Eighties";
    settings = {
      background_opacity = "0.0";
    };
  };
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    package = pkgs.swayfx;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      startup = [
        { command = "waybar"; }
        { command = "nm-applet"; }
        { command = "blueman-applet"; }
        { command = "swww-daemon"; }
        { command = "swww img ~/Downloads/purple.png"; }
      ];
      keybindings = lib.mkOptionDefault {
        "${smod}+d" = "exec pkill -x rofi || rofi -show drun";
        "${smod}+t" = "exec ${terminal}";
        "XF86AudioMute" = "exec pamixer --toggle-mute";
        "XF86AudioRaiseVolume" = "exec  pamixer --increase 5";
        "XF86AudioLowerVolume" = "exec  pamixer --decrease 5";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "${smod}+p" = "exec grimblast copysave area";
      };
      bars = [ ];
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          repeat_delay = "300";
          repeat_rate = "80";
        };
      };
      colors = {
        focused = {
          background = "#800080";
          border = "#800080";
          childBorder = "#800080";
          indicator = "#2e9ef4";
          text = "#ffffff";
        };
      };
    };
    extraConfig = ''
      blur enable
      blur_xray disable
      blur_passes 2
      blur_radius 5

      # Window border settings
      default_border pixel 2
      default_floating_border pixel 2
      smart_borders off

      # Additional window rules (optional)
      for_window [app_id=".*"] opacity 0.90
      for_window [class=".*"] opacity 0.90
    '';
  };
  home.stateVersion = "24.05";
  programs = {
    firefox = {
      enable = true;
    };
    chromium = {
      enable = true;
    };
    home-manager.enable = true;
    starship.enable = true;
    starship.settings = {
      hostname.ssh_only = true;
      hostname.style = "bold green";
    };

    fzf.enable = true;
    fzf.enableZshIntegration = true;
    # lsd.enable = true;
    # lsd.enableAliases = true;
    zoxide.enable = true;
    zoxide.enableZshIntegration = true;
    broot.enable = true;
    broot.enableZshIntegration = true;

    direnv.enable = true;
    direnv.enableZshIntegration = true;
    direnv.nix-direnv.enable = true;

    git = {
      enable = true;
      package = pkgs.git;
      delta.enable = true;
      delta.options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
      };
      userEmail = "shirishmaharjan64@gmail.com";
      userName = "sirimhrzn";
    };

    zsh = {
      enable = true;
      autocd = true;
      # autoSuggestion.enable = true;
      defaultKeymap = "emacs";
      history.size = 100000;
      history.save = 100000;
      history.expireDuplicatesFirst = true;
      history.ignoreDups = true;
      history.ignoreSpace = true;
      historySubstringSearch.enable = true;

      plugins = [
        {
          name = "fast-syntax-highlighting";
          src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
        }
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.5.0";
            sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          };
        }
      ];

      shellAliases = {
        nnn = "bash ~/Documents/geniusvpn/startgpn.sh";
        zel = "zellij -l ~/layout.kdl";
      };

      envExtra = ''
        export PATH=$PATH:$HOME/.local/bin
      '';
    };
  };
}
