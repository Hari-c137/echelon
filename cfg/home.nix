{...}: {
  home.username = "x137";
  home.homeDirectory = "/home/x137";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  imports = [
    ./editors/editors.nix
    ./shells/shells.nix
    ./programs/programs.nix
    ./cli/cli.nix
    ./foot.nix
    ./terminal
    ./mangowc.nix
    ./wall.nix
    ./quickshell.nix
    ./niri.nix
    ./../symlinks/symlinks.nix
    ./mpv.nix
    ./virtualization.nix
  ];
}
