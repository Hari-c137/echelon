{pkgs, ...}: {
  programs.fd = {
    enable = true;
    hidden = true;
    package = pkgs.fd;
    extraOptions = [
      "--no-ignore"
      "--absolute-path"
    ];
    ignores = [
      ".git/"
    ];
  };
}
