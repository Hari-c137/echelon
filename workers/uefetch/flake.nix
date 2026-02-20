{
  description = "A microscopic fetch script in Rust, for NixOS systems";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-linux"];
    forEachSystem = nixpkgs.lib.genAttrs systems;
    pkgsForEach = nixpkgs.legacyPackages;
  in {
    packages = forEachSystem (system: let
      pkgs = pkgsForEach.${system};
    in {
      default = self.packages.${system}.microfetch;
      microfetch = pkgs.callPackage ./nix/package.nix {};
      microfetch-mold = pkgs.callPackage ./nix/package.nix {useMold = true;};
    });

    devShells = forEachSystem (system: {
      default = pkgsForEach.${system}.callPackage ./nix/shell.nix {};
    });
  };
}
