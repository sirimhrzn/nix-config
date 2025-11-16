{lib, ...}: let
  inherit (lib) enabled disabled;
in {
  home-manager.sharedModules = [
    {
      programs.zoxide = enabled {
        enableNushellIntegration = true;
      };
    }
  ];
}
