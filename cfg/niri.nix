{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri-flake.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
}
