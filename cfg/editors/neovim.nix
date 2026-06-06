{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = false;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };
}
