{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) merge mkIf;
in
  merge
  <| mkIf config.isDesktop {
    home-manager.sharedModules = [
      {
        xdg.configFile."Vencord/settings/quickCss.css".text = config.theme.discordCss;
      }
    ];
  }
