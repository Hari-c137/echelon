{pkgs, ...}: {
  security.sudo-rs.enable = true;
  environment.systemPackages = with pkgs; [
    (lib.hiPrio pkgs.uutils-coreutils-noprefix) # what could go wrong..?
  ];
}
