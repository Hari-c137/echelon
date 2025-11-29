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
    ];
    packages = with pkgs; [
      tree
    ];
  };

  services.displayManager.ly.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  security.polkit.enable = true;
  security.sudo-rs = {
    enable = true;
  };

  programs.niri.enable = true;

  services.hardware.openrgb = {
    enable = true;
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
    btop # remove
    polkit_gnome
    gcc # voidbox
    nautilus
    wget
    ncdu
    gitui
    gnumake
    nvtopPackages.amd
    cmake
    fuzzel # remove
    unzip # nonfreerepo
    curl
    heroic # gaming
    pwvucontrol # audio
    fastfetch # cli
  ];

  system.stateVersion = "26.05";
}
