{ pkgs, userSettings, ... }:
let
  lib = import ../../lib { inherit pkgs userSettings; };
in {
  systemd.user.services = {
    power-manager = lib.graphicalService
      "${pkgs.xfce.xfce4-power-manager}/bin/xfce4-power-manager";
    blueman = lib.graphicalService "${pkgs.blueman}/bin/blueman-applet";
    polkit = lib.graphicalService
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };
}
