{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      cursor = {
        style = "Beam";
      };
      terminal.shell = {
        program = "${pkgs.fish}/bin/fish";
      };
      font = {
        size = 14.0;
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };
      };
    };
  };
}
