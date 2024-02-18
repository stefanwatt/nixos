{ userSettings, pkgs, ... }: {
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  security.polkit.enable = true;
  security.rtkit.enable = true;
  systemd = {
    user.services = {
      polkit-gnome-authentication-agent-1 = {
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
        serviceConfig = { ExecStart = "${pkgs.udiskie}/bin/udiskie"; };
      };
    };
  };

  services = {
    dbus.enable = true;
    printing.enable = true;
    blueman.enable = true;
    flatpak.enable = true;
    openssh.enable = true;
    udisks2.enable = true;
  };
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${userSettings.session}";
        user = "${userSettings.username}";
      };
      default_session = {
        command = "${userSettings.session}";
        user = "${userSettings.username}";
      };
    };
  };
  services.udev.packages = [ pkgs.dolphinEmu ];
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    wlr.enable = true;
    config.common.default = "*";
  };
}
