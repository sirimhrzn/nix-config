{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) flatten unique mapAttrsToList const getAttr;
in {
  type = "desktop";
  users.users.siri = {
    name = "siri";
    home = "/Users/siri";
  };

  nix.settings.experimental-features = ["nix-command" "flakes" "pipe-operators"];

  home-manager.users.siri.home = {
    stateVersion = "25.05";
    homeDirectory = config.users.users.siri.home;
  };

  environment.shells = [pkgs.nushell];

  environment.systemPackages = [
    pkgs.bun
  ];

  system.primaryUser = config.users.users.siri.name;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
