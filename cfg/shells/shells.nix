{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./nushell.nix
    ./bash.nix
    ./ion.nix
  ];
  home.packages = with pkgs; [
    shellcheck
  ];
}
