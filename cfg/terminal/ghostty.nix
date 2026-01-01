{...}: {
  programs.ghostty = {
    enable = false;
    enableFishIntegration = true;
    installBatSyntax = true;
    settings = {
      font-size = 13;
      font-family = "Iosevka Nerd Font";
      theme = "Gruvbox Material Dark";
      command = "/run/current-system/sw/bin/fish";
      # custom-shader = "~/code/echelon/workers/shaders/cursor_warp.glsl";
      keybind = [
        "ctrl+shift+l=goto_split:next"
      ];
    };
  };
}
