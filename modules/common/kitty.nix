{
  config,
  lib,
  pkgs,
  ...
} : let
    inherit (lib) enabled disabled;
in {

  home-manager.sharedModules = [
    {
      programs.kitty = disabled {};
    }
  ];
}
