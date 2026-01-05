{pkgs, ...}: {
  programs.alacritty = {
    enable = false;
    package = pkgs.alacritty;
    settings = {
      cursor = {
        style = "Beam";
      };
      terminal.shell = {
        program = "${pkgs.fish}/bin/fish";
      };
      font = {
        size = 18.0;
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };
      };
    };
  };
}
