{pkgs, ...}: {
  containers.i2pd-container = {
    autoStart = true;
    config = {...}: {
      system.stateVersion = "25.11";

      networking.firewall.allowedTCPPorts = [7070 4447 4444 7656];

      services.i2pd = {
        enable = true;
        address = "127.0.0.1";
        proto = {
          sam.enable = true;
          http.enable = true;
          socksProxy.enable = true;
          httpProxy.enable = true;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [librewolf];
}
