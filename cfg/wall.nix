{pkgs, ...}: {
  services.awww = {
    enable = false;
    package = pkgs.awww;
  };
}
