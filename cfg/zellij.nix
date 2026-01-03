{pkgs, ...}: {
  programs.zellij = {
    enable = false;
    package = pkgs.zellij;
    enableFishIntegration = false;
  };
}
