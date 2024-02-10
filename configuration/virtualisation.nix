{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ qtemu qemu_full docker virtualbox ];
  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
}
