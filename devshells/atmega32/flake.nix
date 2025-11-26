{
  description = "devshell for ATmega32 development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      cross = pkgs.pkgsCross.avr;
    in {
      devShells.default = pkgs.mkShell {
        name = "avr-devshell";

        buildInputs = [
          cross.buildPackages.gcc
          cross.buildPackages.binutils
          cross.avrlibc
          pkgs.simulide
        ];

        shellHook = ''
          echo "AVR dev shell active"
          echo "CC = $CC"
          echo "AR = $AR"
          echo "Simulide binary: $(which simulide)"
        '';
      };
    });
}
