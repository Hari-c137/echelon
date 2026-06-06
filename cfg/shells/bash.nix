{
  config,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      werk = "echo baseball huh";
    };
    initExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };
}
