{
  description = " nix-darwin system flake";
  nixConfig = {
    experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    agenix = {
      url = "github:ryantm/agenix";

      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "nix-darwin";
      inputs.home-manager.follows = "home-manager";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";

      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";

      flake = false;
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";

      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    themes.url = "github:RGBCube/ThemeNix";
    zjstatus = {
      url = "github:dj95/zjstatus";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    ...
  }: let
    inherit (nixpkgs.lib) attrsToList const groupBy listToAttrs mapAttrs nameValuePair attrValues getAttrFromPath filter hasAttrByPath hasSuffix;

    lib' = nixpkgs.lib.extend (const <| const <| nix-darwin.lib);
    lib = lib'.extend <| import ./lib inputs;

    collectInputs = let
      inputs' = attrValues inputs;
    in
      path:
        inputs'
        |> filter (hasAttrByPath path)
        |> map (getAttrFromPath path);

    inputHomeModules = collectInputs ["homeModules" "default"];
    inputModulesDarwin = collectInputs ["darwinModules" "default"];
    inputOverlays = collectInputs ["overlays" "default"];
    overlayModule = {
      nixpkgs.overlays =
        inputOverlays
        ++ [
          (final: prev: {
            zjstatus = inputs.zjstatus.packages.${prev.system}.default;
          })
        ];
    };
    listModules' = path: lib.filesystem.listFilesRecursive path |> filter (hasSuffix ".nix");
  in {
    darwinConfigurations."siri" = lib.darwinSystem {
      inherit inputs;
      specialArgs = {
        inherit (inputs) homebrew-cask homebrew-core themes;
        inherit lib self inputs;
      };
      modules =
        [
          overlayModule
          {
            home-manager.sharedModules = inputHomeModules;
          }
          ./hosts/m4siri/default.nix
        ]
        ++ (listModules' modules/darwin)
        ++ (listModules' modules/common)
        ++ inputModulesDarwin;
    };
  };
}
