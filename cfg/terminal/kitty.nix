{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    themeFile = "GruvboxMaterialDarkMedium";
    settings = {
      shell = "fish";
      editor = "hx";
      window_padding_width = 0;
      # window_padding_width = 2;
      #    cursor_trail_decay = "0.1 0.4";
    };
    keybindings = {
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";
      "alt+5" = "goto_tab 5";
      "alt+6" = "goto_tab 6";
      "alt+7" = "goto_tab 7";
      "alt+8" = "goto_tab 8";
      "alt+9" = "goto_tab 9";

      "alt+enter" = "new_window";
      "alt+space" = "new_tab";
      "alt+w" = "close_window";
      "alt+c" = "close_tab";

      "alt+k" = "neighboring_window up";
      "alt+j" = "neighboring_window down";
      "alt+h" = "neighboring_window left";
      "alt+l" = "neighboring_window right";
    };
    font = {
      name = "Iosevka Nerd Font";
      size = 13.7;
    };
    enableGitIntegration = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      scrollback_lines = 20000;
      enable_audio_bell = "no";
      cursor_shape = "beam";
      cursor_trail = 0;
      show_hyperlink_targets = "yes";
      repaint_delay = 7;
      dynamic_background_opacity = "yes";
      input_delay = 2;
      enabled_layouts = "tall, stack, fat, vertical";
      sync_to_monitor = "yes";
      tab_bar_edge = "top";
      tab_bar_min_tabs = 2;
      tab_bar_margin_width = 1.0;
      tab_bar_align = "right";
      tab_title_template = "Tab: {index}";
      active_tab_foreground = "#000";
      active_tab_background = "#73D216";
      active_tab_font_style = "bold-itaLic";
      inactive_tab_foreground = "#444";
      inactive_tab_background = "#999";
      inactive_tab_font_style = "normal";
    };
  };
}
