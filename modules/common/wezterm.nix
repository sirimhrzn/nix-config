{
  config,
  lib,
  pkgs,
  ...
} : let
    inherit (lib) enabled;
in {

  home-manager.sharedModules = [
    {
      programs.wezterm = enabled {};
    }
  ];
}
