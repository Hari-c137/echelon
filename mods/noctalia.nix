{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
    inputs.noctalia-v5.packages.${stdenv.hostPlatform.system}.default
  ];
}
