{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    # package = pkgs.emacs-nox;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  home.packages = with pkgs; [
      pandoc
  ];
  services.emacs.enable = true;
  services.emacs.defaultEditor = false;
}
