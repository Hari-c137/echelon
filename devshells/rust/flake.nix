{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    rust-overlay,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {

      modules = [
        (
          {...}: {
            nixpkgs.overlays = [
              rust-overlay.overlays.default
            ];
          }
        )
        (
          {pkgs, ...}: {
            environment.systemPackages = with pkgs; [
              (rust-bin.stable.latest.default.override {
                targets = ["wasm32-unknown-unknown"];
              })
            ];
          }
        )
      ];
    devShells."x86_64-linux".default = pkgs.mkShell {
      buildInputs = with pkgs; [
        cargo
        rustc
        rustfmt
        clippy
        openssl
        rust-analyzer
        glib
      ];
      nativeBuildInputs = [pkgs.pkg-config];
      env.RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
  };
}
