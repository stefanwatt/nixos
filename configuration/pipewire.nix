{ pkgs, ... }: {
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    ponymix
    pavucontrol
    pulseaudio
    pulseaudio-ctl
  ];
}
