{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) enabled;
  package = pkgs.netbird;
in {
  services.netbird = enabled {
    inherit package;
  };
}
