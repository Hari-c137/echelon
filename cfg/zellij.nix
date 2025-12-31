{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
    enableFishIntegration = true;
  };
}
