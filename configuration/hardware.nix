{ pkgs, ... }: {
  hardware = {
    firmware = [ pkgs.linux-firmware ];
    opengl = {
      extraPackages = [ pkgs.amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth.enable = true;
    pulseaudio.enable = false;
  };
}
