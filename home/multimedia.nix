{ pkgs, ... }: {
  home.packages = with pkgs; [
    simplescreenrecorder
    showmethekey
    gimp
    openshot-qt
    audacity
    autotalent
    vlc
    pix
    mpv
    calibre
    pinta
    ffmpeg
    blender
  ];
}
