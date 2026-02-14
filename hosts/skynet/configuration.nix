{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../mods/source.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "skynet";
    networkmanager = {
      enable = true;
    };
  };

  hardware.bluetooth.enable = false;

  time.timeZone = "Asia/Kolkata";
  nixpkgs.config.allowUnfree = true;

  users.users.x137 = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
      "networkmanager"
    ];
    packages = with pkgs; [
      tree
    ];
  };

  services.displayManager.ly.enable = true;

  security.polkit.enable = true;
  security.sudo-rs = {
    enable = true;
  };

  programs.niri.enable = true;

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "intel";
    server.port = 6742;
    startupProfile = "norgb.orp";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
  ];

  nix.settings = {
    extra-substituters = [
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-trusted-public-keys = [
    ];
  };
  environment.systemPackages = with pkgs; [
    (lib.hiPrio pkgs.uutils-coreutils-noprefix) # what could go wrong..?
    wl-clipboard
    usbutils
    imhex
    # gitu
    polkit_gnome
    rsclock
    gcc # voidbox
    nautilus
    wget
    nodejs
    ncdu
    nim
    nimble
    nph
    microfetch
    gnumake
    nvtopPackages.amd
    cmake
    fuzzel # remove
    unzip # nonfreerepo
    curl
    heroic # gaming
    pwvucontrol # audio
  ];

  system.stateVersion = "26.05";
}
