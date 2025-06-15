{ pkgs, userSettings, ... }:
let
  lib = import ../../lib { inherit pkgs userSettings; };
in {
  systemd.user.services = with userSettings; {
    # dunst = lib.graphicalService
    #   "${pkgs.dunst}/bin/dunst -conf ${lib.userHome}/.dunstrc";
    picom = lib.graphicalService
      "${pkgs.picom}/bin/picom --config ${lib.configPath}/home/i3/config/picom.conf";
    go-launch = lib.graphicalService
      "${lib.userHome}/Projects/go-launch/build/bin/go-launch";
    ai-chat = lib.graphicalService 
      "${lib.userHome}/Projects/ai-chat/build/bin/ai-chat";
    power-manager = lib.graphicalService
      "${pkgs.xfce.xfce4-power-manager}/bin/xfce4-power-manager";
    autokey = lib.graphicalService "${pkgs.autokey}/bin/autokey-gtk";
    flameshot = lib.graphicalService "${pkgs.flameshot}/bin/flameshot";
    blueman = lib.graphicalService "${pkgs.blueman}/bin/blueman-applet";
    clock = lib.graphicalService
      "${pkgs.wezterm}/bin/wezterm --config font_size=40 start --always-new-process --class Clock,Clock tty-clock -n -s";
    scratchpad = lib.graphicalService
      "${pkgs.wezterm}/bin/wezterm start --class scratchpad,scratchpad";
    polkit = lib.graphicalService
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };
}
