{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.amdgpu.overdrive.enable = true;
  hardware.amdgpu.initrd.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services = {
    tuned.enable = true;
    upower.enable = true;
    lact.enable = true;
  };

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };
}
