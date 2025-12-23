{pkgs, ...}: let
  aliasfish = {
    gs = "git status";
    gd = "git diff";
    gp = "git push -u origin main";
    x = "exit";
    mc = "make clean";
    mr = "make release";
    asdf = "frnb";
    md = "make debug";
    re = "sudo nixos-rebuild switch --flake ~/code/echelon#skynet";
    up = "sudo nixos-rebuild --upgrade switch --flake ~/code/echelon#skynet";
    ll = "ls -la";
    l = "ls -l";
  };
in {
  programs.fish = {
    enable = true;
    shellAliases = aliasfish;
    plugins = [
      {
        name = "pure";
        src = pkgs.fishPlugins.pure;
      }
    ];
  };
}
