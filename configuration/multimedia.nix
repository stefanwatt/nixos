{ pkgs, ... }: {
  musnix.enable = true;
  environment.systemPackages = with pkgs; [
    obs-studio
    flameshot
    simplescreenrecorder
    showmethekey
    gimp
    openshot-qt
    audacity
    talentedhack
    autotalent
    vlc
    ardour
    cura
    infamousPlugins
    x42-plugins
    easyeffects
    spotify
    cinnamon.pix
    video-trimmer
    mpv
    calibre
    pinta
    gmrender-resurrect
    ffmpeg
  ];
}
