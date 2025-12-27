{pkgs, ...}: {
  home.packages = with pkgs; [
    tinymist
    zathuraPkgs.zathura_pdf_mupdf
    zathuraPkgs.zathura_cb
    #    fancy-cat
  ];
  programs.zathura = {
    enable = true;
    package = pkgs.zathura;
  };
}
