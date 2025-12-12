{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    loadModels = [
      "deepseek-r1:7b"
      "goekdenizguelmez/JOSIEFIED-Qwen3:4b"
    ];
  };
}
