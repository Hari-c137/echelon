{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nasm
  ];
}
