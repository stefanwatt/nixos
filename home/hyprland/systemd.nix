{ pkgs, ... }:
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
  systemd.user.services = {
    power-manager = graphicalService
      "${pkgs.xfce.xfce4-power-manager}/bin/xfce4-power-manager";
    blueman = graphicalService "${pkgs.blueman}/bin/blueman-applet";
    polkit = graphicalService
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };
}
