{
  lib,
  stdenv,
  stdenvAdapters,
  rustPlatform,
  llvm,
  useMold ? stdenv.isLinux,
}: let
  toml = (lib.importTOML ../Cargo.toml).package;
  pname = toml.name;
  inherit (toml) version;

  # Select stdenv based on useMold flag
  stdenv =
    if useMold
    then stdenvAdapters.useMoldLinker llvm.stdenv
    else llvm.stdenv;
in
  rustPlatform.buildRustPackage.override {inherit stdenv;} {
    inherit pname version;
    src = let
      fs = lib.fileset;
      s = ../.;
    in
      fs.toSource {
        root = s;
        fileset = fs.unions [
          (fs.fileFilter (file: builtins.any file.hasExt ["rs"]) (s + /src))
          (s + /Cargo.lock)
          (s + /Cargo.toml)
          (s + /benches)
        ];
      };

    cargoLock.lockFile = ../Cargo.lock;
    enableParallelBuilding = true;
    buildNoDefaultFeatures = true;
    doCheck = false;

    # Only set RUSTFLAGS for mold if useMold is enabled
    env = lib.optionalAttrs useMold {
      CARGO_LINKER = "clang";
      RUSTFLAGS = "-C link-arg=-fuse-ld=mold";
    };

    meta = {
      description = "Microscopic fetch script in Rust, for NixOS systems";
      homepage = "https://github.com/NotAShelf/microfetch";
      license = lib.licenses.gpl3Only;
      maintainers = [lib.maintainers.NotAShelf];
      mainProgram = "microfetch";
    };
  }
