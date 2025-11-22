{
  description = "Echelon";

  outputs =
    {
      self,
      nixpkgs,
      chaotic,
      rust-overlay,
      nix-doom-emacs-unstraightened,
      mango,
      nix-topology,
      home-manager,
      zen-browser,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-topology.overlays.default ];
      };
    in
    {
      nixosConfigurations.skynet = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          (
            { pkgs, lib, ... }:
            {
              nixpkgs.overlays = [
                rust-overlay.overlays.default
                inputs.niri.overlays.niri
                nix-topology.overlays.default
              ];
            }
          )
          ./hosts/skynet/configuration.nix
          chaotic.nixosModules.default
          nix-topology.nixosModules.default
          mango.nixosModules.mango
          (
            { pkgs, ... }:
            {
              environment.systemPackages = with pkgs; [
                (rust-bin.stable.latest.default.override {
                  targets = [ "wasm32-unknown-unknown" ];
                })
              ];
            }
          )
          (
            { pkgs, ... }:
            {
              environment.systemPackages = with pkgs; [
                nim
                nimble
              ];
            }
          )
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.x137 = import ./cfg/home.nix;
              extraSpecialArgs = {
                inherit inputs;
                inherit system;
              };
            };
          }
        ];
      };
      topology.x86_64-linux = import nix-topology {
        inherit pkgs;
        modules = [
          ./mods/topology.nix
          { nixosConfigurations = self.nixosConfigurations; }
        ];
      };

    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-topology = {
      url = "github:oddlama/nix-topology";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
