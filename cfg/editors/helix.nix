{
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = false;
    settings = {
      theme = "ayu_dark";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      editor = {
        line-number = "relative";
        mouse = false;
        auto-completion = true;
        auto-save = true;
        auto-format = true;

        file-picker = {
          hidden = false;
        };

        lsp = {
          enable = true;
          auto-signature-help = true;
          display-messages = true;
        };
      };
    };

    languages.language-server.wakatime = {
      command = "wakatime-ls";
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
        language-servers = [
          "nil"
          "wakatime"
        ];
      }
      {
        name = "rust";
        language-servers = [
          "rust-analyzer"
          "wakatime"
        ];
      }
    ];
    extraPackages = with pkgs; [
      nil
      inputs.wakatime-ls.packages."${stdenv.hostPlatform.system}".default
      markdown-oxide
    ];
  };
}
