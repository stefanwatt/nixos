{ pkgs, ... }:
let xrandr-config = import ./scripts/xrandr.nix { inherit pkgs; };
in {

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    videoDrivers = [ "amdgpu" ];

    desktopManager = { xterm.enable = false; };

    displayManager = {
      defaultSession = "none+i3";
      autoLogin = {
        enable = true;
        user = "stefan";
      };
      sessionCommands = ''
        ${xrandr-config.script}/bin/xrandr-config
      '';
    };

    windowManager.i3.enable = true;
  };
  environment.systemPackages = with pkgs; [ i3 ];
}
