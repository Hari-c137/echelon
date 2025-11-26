{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellScriptBin "frnb" ''
   (
     RELOAD='reload:${pkgs.ripgrep}/bin/rg --column --color=always --smart-case {q} || :'
     OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
        $EDITOR {1} +{2}
      else
        $EDITOR +cw -q {+f}
      fi'
     ${pkgs.fzf}/bin/fzf --disabled --ansi --multi \
  --bind "start:$RELOAD" --bind "change:$RELOAD" \
  --bind "enter:become:$OPENER" \
  --bind "ctrl-o:execute:$OPENER" \
  --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
  --delimiter : \
  --preview '${pkgs.bat}/bin/bat --style=full --color=always --highlight-line {2} {1}' \
  --preview-window '~4,+{2}+4/3,<80(up)' \
  --query "$*"
   )
''
