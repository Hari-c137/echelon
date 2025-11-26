{
  inputs,
  pkgs,
  outputs,
  ...
}: let
  cachykernel = pkgs.linuxPackages_cachyos.kernel;
in {
  nixpkgs.overlays = [
    outputs.overlays.unstable-packages
    inputs.chaotic.overlays.default
  ];
  chaotic.nyx.cache.enable = true;
  imports = [inputs.chaotic.nixosModules.default];

  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  #system.modulesTree = [ (lib.getOutput "modules" cachykernel) ];
  services.ananicy = {
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos_git;
    enable = true;
  };
}
