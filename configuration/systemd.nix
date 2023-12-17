{ config, pkgs, ... }: {
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd = {
    user.services = {
      polkit-gnome-authentication-agent-1= {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart =
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
      udiskie = {
        description = "udiskie automount service";
        wantedBy = [ "default.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.udiskie}/bin/udiskie";
        };
      };
    };
  };
}
