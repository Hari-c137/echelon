{
  config,
  lib,
  ...
}: let
  cfgs = ["niri" "doom" "ewwii" "nvim" "mpv" "wezterm"];
in {
  xdg.configFile = lib.genAttrs cfgs (name: {
    source =
      config.lib.file.mkOutOfStoreSymlink
      "/home/x137/code/echelon/symlinks/${name}/";
    recursive = true;
  });
}
