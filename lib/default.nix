inputs: self: super: let
  values = import ./values.nix inputs self super;
  option = import ./option.nix inputs self super;
in
  values // option
