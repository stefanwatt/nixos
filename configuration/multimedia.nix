{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    flameshot
    simplescreenrecorder
    showmethekey
    gimp
    openshot-qt
    audacity
    vlc
    ardour
    cura
    infamousPlugins
    x42-plugins
    easyeffects
  ];
}
