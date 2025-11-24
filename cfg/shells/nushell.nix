{ ... }:

{
  programs.nushell = {
    enable = true;
    shellAliases = {
      gs = "git status";
      gd = "git diff";
      gp = "git push -u origin main";
      x = "exit";
      mc = "make clean";
      mr = "make release";
      md = "make debug";
      re = "sudo nixos-rebuild switch --flake ~/code/echelon#skynet";
      up = "sudo nixos-rebuild --upgrade switch --flake ~/code/echelon#skynet";
      ll = "ls -la";
      l = "ls -l";
    };
    settings = {
      buffer_editor = "hx";
      show_banner = false;
    };
  };
}
