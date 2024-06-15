{ pkgs, userSettings, ... }:
let
  graphicalService = execStart: {
    Unit = {
      Description = execStart;
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = {
      Type = "simple";
      ExecStart = execStart;
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
      Environment = [
        "DISPLAY=:0"
        "PATH=${pkgs.ps}/bin:/run/current-system/sw/bin:/home/stefan/.nix-profile/bin/"
      ];
    };
  };
in {
  systemd.user.services = with userSettings; {
    dunst = graphicalService
      "${pkgs.dunst}/bin/dunst -conf /home/${username}/.dunstrc";
    picom = graphicalService
      "${pkgs.picom}/bin/picom --config /home/${username}/.config/nixos/home/i3/config/picom.conf";
    go-launch = graphicalService
      "/home/${username}/Projects/go-launch/build/bin/go-launch";
    power-manager = graphicalService
      "${pkgs.xfce.xfce4-power-manager}/bin/xfce4-power-manager";
    autokey = graphicalService "${pkgs.autokey}/bin/autokey-gtk";
    flameshot = graphicalService "${pkgs.flameshot}/bin/flameshot";
    blueman = graphicalService "${pkgs.blueman}/bin/blueman-applet";
    clock = graphicalService
      "${pkgs.wezterm}/bin/wezterm --config font_size=40 start --always-new-process --class Clock,Clock tty-clock -n -s";
    scratchpad = graphicalService
      "${pkgs.wezterm}/bin/wezterm start --class scratchpad,scratchpad";
    polkit = graphicalService
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";

  };
}
