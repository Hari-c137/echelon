{...}: {
  programs.bottom.enable = true;
  programs.bottom.settings = {
    flags = {
      process.default_memory_value = true;
      cpu.left_legend = true;
      enable_gpu = true;
      memory_graph.cache_memory = true;
      processes.process_command = true;
      processes.regex = true;
    };
  };
}
