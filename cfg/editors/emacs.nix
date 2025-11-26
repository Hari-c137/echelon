{pkgs, ...}: {
  programs.emacs = {
    enable = false;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  home.packages = with pkgs; [
    pandoc
  ];
  services.emacs.enable = false;
  services.emacs.defaultEditor = false;
}
