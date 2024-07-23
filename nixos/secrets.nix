{ pkgs, lib, ... }:
let
  secrets = pkgs.lib.importTOML ./secrets.toml;
  database = secrets.database;
  aliaser =
    {
      alias,
      host,
      username,
      password,
    }:
    "alias -- '${alias}'='mariadb -h ${host} -u ${username} -p${password}'";
  databaseVars = builtins.mapAttrs (
    env: envName:
    builtins.attrValues (
      builtins.mapAttrs (key: val: val) (
        builtins.mapAttrs (
          alias: aliasValue:
          let
            alVal = aliaser {
              inherit (aliasValue) host username password;
              inherit alias;
            };
          in
          "${alVal}"
        ) envName
      )
    )
  ) database.env;
  shellHook = builtins.concatLists (
    map (
      value: if builtins.isList value then builtins.concatLists (map (val: [ val ]) value) else [ value ]

    ) (builtins.attrValues databaseVars)
  );
in
{
  secret = {
    hooks =
      if (builtins.pathExists ./secrets.toml) then builtins.concatStringsSep "\n" shellHook else "";
  };
}
