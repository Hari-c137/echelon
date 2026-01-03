{pkgs, ...}: {
  services.ollama = {
    enable = false;
    package = pkgs.ollama-rocm;
    loadModels = [
      "deepseek-r1:7b"
      "goekdenizguelmez/JOSIEFIED-Qwen3:4b"
    ];
  };
}
