{ config, pkgs, ... }: {
  hardware = {
    opengl = {
      extraPackages = [ pkgs.amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth.enable = true;
    pulseaudio.enable = false;
  };
}
