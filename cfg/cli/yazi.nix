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
      show_hidden = false;
      sort_dir_first = true;
      sort_reverse = true;
    };
    shellWrapperName = "yy";
  };
}
