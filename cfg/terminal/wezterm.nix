{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
  };
}
