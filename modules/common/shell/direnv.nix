{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) enabled;
  package = pkgs.direnv;
in {
  home-manager.sharedModules = [
    {
      programs.direnv = enabled {
        inherit package;
        enableNushellIntegration = true;
        enableZshIntegration = true;
        nix-direnv = enabled {};
      };
    }
  ];
}
