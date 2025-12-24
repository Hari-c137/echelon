{...}: {
  programs.jujutsu = {
    enable = true;

    settings = {
      ui = {
        editor = "hx";
      };
      user = {
        name = "clearlyopaque";
        email = "ramk487574@gmail.com";
      };
    };
  };
  programs.delta.enableJujutsuIntegration = true;
}
