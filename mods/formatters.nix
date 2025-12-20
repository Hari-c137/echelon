{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    stylua
    shfmt
    alejandra
    kdePackages.qt5compat
    kdePackages.qtsvg
    kdePackages.qtimageformats
    nimlangserver
    kdePackages.qtmultimedia
    kdePackages.qtdeclarative
    wasm-pack
  ];
}
