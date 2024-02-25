{ userSettings, ... }: {
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    videoDrivers = [ "amdgpu" ];
    windowManager.i3.enable = true;
    displayManager = {
      defaultSession = "none+i3";
      autoLogin = {
        enable = true;
        user = userSettings.username;
      };
    };
  };
}
