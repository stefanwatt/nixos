{ userSettings, ... }: {
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = userSettings.username;
    };
    defaultSession = "none+i3";
  };
  services.xserver = {
    enable = true;
    xkb = {
      variant = "";
      layout = "us";
    };
    videoDrivers = [ "amdgpu" ];
    windowManager.i3.enable = true;
  };
}
