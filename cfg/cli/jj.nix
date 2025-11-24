{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.jujutsu = {
    enable = true;

    settings = {
      ui = {
        editor = "hx";
      };
      user = {
        name = "ClearlyOpaque";
        email = "hariprasadaji465@gmail.com";
      };
    };
  };
  programs.delta.enableJujutsuIntegration = true;
}
