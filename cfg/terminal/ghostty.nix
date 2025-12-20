{...}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    installBatSyntax = true;
    settings = {
      font-size = 18;
      font-family = "Iosevka Nerd Font";
      theme = "Gruvbox Material Dark";
      command = "/run/current-system/sw/bin/fish";
      # custom-shader = "~/code/echelon/workers/shaders/cursor_warp.glsl";
    };
  };
}
