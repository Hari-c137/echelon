{
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = pkgs.helix;

    extraPackages = with pkgs; [
      markdown-oxide
      rust-analyzer
      nimlangserver
      glsl_analyzer
      nixd
      inputs.wakatime-ls.packages."${stdenv.hostPlatform.system}".default
    ]; # rust, nim, glsl, nix

    settings = {
      theme = "gruvbox-material";
      editor = {
        mouse = false;
        line-number = "relative";
        file-picker.hidden = false;
        auto-completion = true;
        auto-save = true;
        auto-format = true;

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        lsp = {
          enable = true;
          auto-signature-help = true;
          display-message = true;
          display-inlay-hints = true;
          inlay-hints-length-limit = 2;
        };
      };
    };

    languages = {
      language-server = {
        nixd = {command = "nixd";};
        waka = {command = "wakatime-ls";};
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.alejandra}/bin/alejandra";
          };
          language-servers = ["nixd" "waka"];
        }
        {
          name = "nim";
          auto-format = true;
          language-servers = ["nimlangserver" "waka"];
        }
        {
          name = "rust";
          language-servers = ["rust-analyzer" "waka"];
        }
      ];
    };
  };
}
