{
  mkShell,
  cargo,
  rustc,
  mold,
  clang,
  rust-analyzer-unwrapped,
  rustfmt,
  clippy,
  taplo,
  rustPlatform,
  gnuplot,
}:
mkShell {
  name = "microfetch";
  strictDeps = true;
  nativeBuildInputs = [
    cargo
    rustc
    mold
    clang

    rust-analyzer-unwrapped
    (rustfmt.override {asNightly = true;})
    clippy
    taplo

    gnuplot # for Criterion.rs plots
  ];

  env.RUST_SRC_PATH = "${rustPlatform.rustLibSrc}";
}
