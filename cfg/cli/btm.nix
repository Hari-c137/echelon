{...}: {
  programs.bottom.enable = true;
  programs.bottom.settings = {
    flags = {
      process_memory_as_value = true;
      cpu_left_legend = true;
      enable_gpu = true;
      enable_cache_memory = true;
      process_command = true;
      regex = true;
    };
  };
}
