{inputs, ...}: {
  environment.systemPackages = [inputs.amane.packages.x86_64-linux.default];
}
