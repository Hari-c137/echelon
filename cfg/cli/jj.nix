{...}: {
  programs.jujutsu = {
    enable = true;

    settings = {
      ui = {
        editor = "hx";
      };
      user = {
        name = "clearlyopaque";
        email = "hariprasadaji465@gmail.com";
      };
    };
  };
  programs.delta.enableJujutsuIntegration = true;
}
