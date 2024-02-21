{ pkgs, userSettings, ... }:
let
  path = with userSettings;
    "/home/${username}/.config/nvim/lua/config/paths.lua";
  startupScript = import ./startup.nix {
    inherit pkgs;
    inherit userSettings;
  };
in {
  home.file."${path}" = {
    text = ''
      return {
        wm_config = "${userSettings.wm.configFilePath}"
      }
    '';
    force = true;
  };
  environment.systemPackages = with pkgs; [
    i3
    autokey
    arandr
    xdotool
    nitrogen
    picom-jonaburg
    rofi
    xfce.xfce4-power-manager
    xclip
    xorg.xkill
    xorg.libX11
    xorg.xsetroot
  ];
  xsession = {
    enable = true;
    initExtra = startupScript;
    windowManager = { i3 = { enable = true; }; };
  };
}
