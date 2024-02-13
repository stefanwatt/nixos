{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ docker virtualbox ];
  virtualisation = {
    docker.enable = true;
    # virtualbox.host = {
    #   enable = true;
    #   enableExtensionPack = true;
    # };
  };
}
