{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    plugins = {};

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;

    settings = {
      log = {
        enabled = false;
      };
      show-hidden = false;
      sort-dir_first = true;
      sort-reverse = true;
    };
    shellWrapperName = "yy";
  };
}
