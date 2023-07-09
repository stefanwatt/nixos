{ config, pkgs, ... }: {
  hardware = {
    opengl.extraPackages = [ pkgs.amdvlk ];
    bluetooth.enable = true;
    pulseaudio.enable = false;
  };
}
