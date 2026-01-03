{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
    extensions = [
      "rust"
      "nim"
      "nix"
      "glsl"
    ];
    userSettings = {
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      helix_mode = true;
      ui_font_size = 19;
      buffer_font_size = 19;
    };
  };
}
