{...}: {
  programs.virt-manager = {
    enable = true;
  };
  users.groups.libvirtd.members = ["x137"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
