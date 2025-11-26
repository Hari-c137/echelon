{config, ...}:
# todo: refactor this with loop
{
  xdg.configFile."niri" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/x137/code/echelon/symlinks/niri/";
    recursive = true;
  };

  xdg.configFile."doom" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/x137/code/echelon/symlinks/doom/";
    recursive = true;
  };

  xdg.configFile."ewwii" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/x137/code/echelon/symlinks/ewwii/";
    recursive = true;
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/x137/code/echelon/symlinks/nvim/";
    recursive = true;
  };

  xdg.configFile."mpv" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/x137/code/echelon/symlinks/mpv/";
    recursive = true;
  };
}
