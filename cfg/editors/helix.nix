{
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = false;
    settings = {
      theme = "gruvbox-material";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };

      keys = {
        normal = {
          ret = "goto_word";
        };
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
          display-inlay-hints = true;
          inlay-hints-length-limit = 5;
        };
      };
    };

    languages.language-server.wakatime = {
      command = "wakatime-ls";
    };

    languages.language-server.nixd = {
      command = "nixd";
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
        language-servers = [
          "nixd"
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
      nixd
      inputs.wakatime-ls.packages."${stdenv.hostPlatform.system}".default
      markdown-oxide
    ];
  };
}
