{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
in {
  launchd.daemons."silverbullet-m4siri" = {
    command = "${getExe pkgs.silverbullet} ~/Documents/sb-m4siri -p 14000";
    serviceConfig = {
      KeepAlive = true;
      Label = "silverbullet-notes";
    };
  };
}
