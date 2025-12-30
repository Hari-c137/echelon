{
  pkgs,
  outputs,
  ...
}: {
  nixpkgs.overlays = [
    outputs.overlays.unstable-packages
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  #system.modulesTree = [ (lib.getOutput "modules" cachykernel) ];
  services.ananicy = {
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
    enable = true;
  };
}
