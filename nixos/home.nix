{
  config,
  lib,
  pkgs,
  ...
}:
let
  secrets = import ./secrets.nix { inherit pkgs lib; };
in
{
  imports = [
    ./swaywm.nix
    ./hypr.nix
  ];
  home.username = "sirimhrzn";
  home.homeDirectory = "/home/sirimhrzn";

  home.packages = [
    pkgs.kitty-themes
    pkgs.wlsunset
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

  programs.kitty = {
    enable = true;
    font.name = "ComicShannsMono Nerd Font";
    theme = "Fideloper";
    settings = {
      background_opacity = "60.0";
      term = "xterm-256color";
      font_size = "11.0";
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
    zoxide.enable = true;
    zoxide.enableZshIntegration = true;

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
  programs.zsh = {
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
      gl = "git log --oneline";
      idid = "nvim ~/idid.md";
      ket = "kubectl get pods | rg ";
      kex = "kubectl exec -it ";
      k = "kubectl";
      d = "docker";
      dc = "docker compose";
      ".." = "cd ..";
      "...." = "cd ../..";
    };

    envExtra = ''
      export PATH=$PATH:$HOME/.local/bin
      export KUBE_EDITOR=nvim
      ${secrets.secret.mariaDbHooks}
    '';
  };
}
