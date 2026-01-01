{pkgs, ...}: {
  programs.ion = {
    enable = false;
    package = pkgs.ion;
    shellAliases = {
      gs = "git status";
      gp = "git push -u origin main";
    };
  };
}
