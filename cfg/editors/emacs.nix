{pkgs, ...}: {
  programs.emacs = {
    enable = true;
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
