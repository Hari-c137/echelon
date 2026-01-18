{
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
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

    languages.language-server.tinymist = {
      command = "tinymist";
      config = {
        typstExtraArgs = ["main.typ"];
        exportPdf = "oneType";
        preview.background.enabled = true;
        preview.background.args = [
          "--data-plane-host=127.0.0.1:0"
          "--invert-colors=never"
          "--open"
        ];
      };
    };

    languages.language-server.nixd = {
      command = "nixd";
    };

    languages.language = [
      {
        name = "nix";
        auto-format = false;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
        language-servers = [
          "nixd"
          "wakatime"
        ];
      }
      {
        name = "cpp";
        auto-format = true;
        language-servers = [
          "clangd"
          "wakatime"
        ];
      }
      {
        name = "glsl";
        auto-format = true;
        language-servers = [
          "glsl_analyzer"
          "wakatime"
        ];
      }
      {
        name = "nim";
        auto-format = true;
        formatter.command = "nph";
        language-servers = [
          "nimlangserver"
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
      {
        name = "typst";
        language-servers = [
          "tinymist"
          "wakatime"
        ];
      }
    ];
    extraPackages = with pkgs; [
      inputs.wakatime-ls.packages."${stdenv.hostPlatform.system}".default
      rust-analyzer
      wgsl-analyzer
      markdown-oxide
      nixd
      clang-tools
    ];
  };
}
