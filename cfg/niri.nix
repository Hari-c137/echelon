{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri-flake.homeModules.niri
  ];
  home.packages = with pkgs; [
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
