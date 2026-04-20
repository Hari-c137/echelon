{...}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "rust"
      "nim"
      "nix"
      "glsl"
    ];
    userSettings = {
      telemetry = {
        metrics = false;
      };
      helix_mode = true;
      ui_font_size = 19;
      buffer_font_size = 19;
    };
  };
}
