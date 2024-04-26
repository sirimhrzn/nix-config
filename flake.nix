{
  description = "sirixnix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    nixpkgs-unstable.url =  "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable }:
  let 
     system = "x86_64-linux";
     pkgs = import nixpkgs {
        inherit system;
        config = {
           allowUnfree = true;
        };
     };
  in
  {
     nixosConfigurations = {
      sirimhrzn = nixpkgs.lib.nixosSystem {
	specialArgs = { inherit system; };
	modules =
	      let
        	defaults = { pkgs, ... }: {
          	_module.args.nixpkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
        	};
	      in
 	[
		defaults
		./nixos/configuration.nix
	];
      };
     };
  };
}
