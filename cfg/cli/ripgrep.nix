{pkgs, ...}: {
  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep;
    arguments = [
      "--max-columns-preview"
      "--colors=line:style:bold"
    ];
  };
  programs.ripgrep-all = {
    enable = true;
    package = pkgs.ripgrep;
  };
}
