{ pkgs, ... }: {
  # environment.systemPackages = with pkgs; [ docker ];
  virtualisation = {
    # docker.enable = true;
    # virtualbox.host = {
    #   enable = true;
    #   enableExtensionPack = true;
    # };
  };
}
