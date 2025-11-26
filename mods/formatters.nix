{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    stylua
    shfmt
    alejandra
    kdePackages.qt5compat
    kdePackages.qtsvg
    kdePackages.qtimageformats
    kdePackages.qtmultimedia
    kdePackages.qtdeclarative
    rust-analyzer
    wasm-pack
  ];
}
