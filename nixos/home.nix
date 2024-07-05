{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./swaywm.nix
    # ./hypr.nix
  ];
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
    theme = "Tomorrow Night Eighties";
    settings = {
      background_opacity = "0.0";
    };
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
    # broot.enable = true;
    # broot.enableZshIntegration = true;

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
  };
  programs.zsh = 
  let
  	secrets = builtins.readFile ./secrets;
  in
  {
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

      shellAliases = {
        nnn = "bash ~/Documents/geniusvpn/startgpn.sh";
        zel = "zellij -l ~/layout.kdl";
        nv = "fzf | xargs nvim";
        kb = "~/.cargo/bin/rust-kanban";
      };
      
      envExtra = ''
export PATH=$PATH:$HOME/.local/bin
${secrets}
      '';
  };
}
