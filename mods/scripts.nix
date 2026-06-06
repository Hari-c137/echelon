{
  config,
  pkgs,
  ...
}: let
  frnb = import ../workers/scripts/frnb.nix {inherit pkgs;};
in {
  environment.systemPackages = [frnb];
}
