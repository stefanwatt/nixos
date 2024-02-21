{ userSettings, ... }: {
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    videoDrivers = [ "amdgpu" ];
    desktopManager = { xterm.enable = false; };
    displayManager = {
      defaultSession = "none+${userSettings.wm.name}";
      autoLogin = {
        enable = true;
        user = userSettings.username;
      };
    };
  };
}
