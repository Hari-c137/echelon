{pkgs, ...}: {
  programs.zoxide = {
    enable = false;
    package = pkgs.zoxide;
    options = [];
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
}
