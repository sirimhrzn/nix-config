{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) enabled mkIf filterAttrs attrNames mapAttrs head remove;
  controlPath = "~/.ssh/control";
in {
  secrets.sshConfig = {
    file = ./config.age;
    mode = "444";
  };

  home-manager.sharedModules = [
    (homeArgs: let
      lib' = homeArgs.lib;

      inherit (lib'.hm.dag) entryAfter;
    in {
      home.activation.createControlPath =
        entryAfter ["writeBoundary"]
        /*
        bash
        */
        ''
          mkdir --parents ${controlPath}
        '';

      programs.ssh = enabled {
        includes = [config.secrets.sshConfig.path];

        enableDefaultConfig = false; # Deprecated.
        matchBlocks = {
          "*" = {
            controlMaster = "auto";
            # controlPath = "${controlPath}/%r@%n:%p";
            controlPath = "/tmp/ssh-%u-%C";
            controlPersist = "60m";
            serverAliveCountMax = 2;
            serverAliveInterval = 60;

            setEnv.COLORTERM = "truecolor";
            setEnv.TERM = "xterm-256color";

            identityFile = "~/.ssh/id_rsa";
          };
        };
      };
    })
  ];

  environment = mkIf config.isDesktop {
    systemPackages = [pkgs.mosh];
    shellAliases.mosh = "mosh --no-init";
  };
}
