{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [inputs.helium.defaultPackage.${stdenv.hostPlatform.system}];
}
