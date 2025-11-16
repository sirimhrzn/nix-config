{
  self,
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) attrsToList concatStringsSep const disabled filter filterAttrs flip id isType mapAttrs mapAttrsToList merge mkAfter optionalAttrs optionals;
  inherit (lib.strings) toJSON;

  registryMap =
    inputs
    |> filterAttrs (const <| isType "flake");
in {
  nix.distributedBuilds = true;

  nix.channel = disabled;

  nix.gc = merge {
    automatic = true;
    options = "--delete-older-than 3d";
  };

  nix.optimise.automatic = true;

  environment.systemPackages = [
    pkgs.nh
    pkgs.nix-index
    pkgs.nix-output-monitor
  ];

  home-manager.sharedModules = [
    {
      programs.nushell.configFile.text =
        mkAfter
        /*
        nu
        */
        ''
          def --wrapped * [program: string = "", ...arguments] {
            if ($program | str contains "#") or ($program | str contains ":") {
              nix run $program -- ...$arguments
            } else {
              nix run ("default#" + $program) -- ...$arguments
            }
          }

          def --wrapped > [...programs] {
            nix shell ...($programs | each {
              if ($in | str contains "#") or ($in | str contains ":") {
                $in
              } else {
                "default#" + $in
              }
            })
          }
        '';
    }
  ];
}
