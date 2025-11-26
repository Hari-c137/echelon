{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
  ];
}
