{ config, pkgs, ... }: {
  services.xserver = {
    layout = "us";
    xkbVariant = "";

    enable = true;

    desktopManager = { xterm.enable = false; };

    displayManager = {
      defaultSession = "none+i3";
      autoLogin = {
        enable = true;
        user = "stefan";
      };
    };

    windowManager.i3.enable = true;
  };
}
