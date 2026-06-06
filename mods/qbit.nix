{...}: {
  services.qbittorrent = {
    enable = true;
    user = "x137";
    extraArgs = ["--confirm-legal-notice"];
    webuiPort = 1337;
    openFirewall = true;
    serverConfig = {
      LegalNotice.Accepted = true;
      Preferences = {
        WebUI = {
          AuthenticationRequired = false;
          Username = "x137";
          Password_PBKDF2 = "W91a8HKbc2XOK6IamWxH4w==:RDlNstgiAt4HOegPlAUnqYtMX3EcQw6nh7otKfxEZq0rEdYigDh8/DApMTslN0WpoNoA9PSWvS+iPAdVM2J66w=="; # # black-magic
        };
      };
    };
  };
}
