{
  description = "Echelon";

  outputs = {
    self,
    nixpkgs,
    chaotic,
    nixos-generators,
    niri-flake,
    rust-overlay,
    mango,
    home-manager,
    zen-browser,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    buildiso = nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      modules = [
        ./hosts/skynet/configuration.nix
      ];
      format = "iso";
    };
    nixosConfigurations.skynet = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        (
          {
            pkgs,
            lib,
            ...
          }: {
            nixpkgs.overlays = [
              rust-overlay.overlays.default
              inputs.niri-flake.overlays.niri
            ];
          }
        )
        ./hosts/skynet/configuration.nix
        chaotic.nixosModules.default
        mango.nixosModules.mango
        (
          {pkgs, ...}: {
            environment.systemPackages = with pkgs; [
              (rust-bin.stable.latest.default.override {
                targets = ["wasm32-unknown-unknown"];
              })
            ];
          }
        )
        (
          {pkgs, ...}: {
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
              inherit inputs system;
            };
          };
        }
      ];
    };
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
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
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wakatime-ls = {
      url = "github:mrnossiom/wakatime-ls";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
