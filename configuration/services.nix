{ userSettings, pkgs, ... }:
let
  graphicalService = execStart: {
    description = execStart;
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = execStart;
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
in {
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  security.polkit.enable = true;
  security.rtkit.enable = true;
  systemd = {
    user.services = with userSettings; {
      polkit-gnome-authentication-agent-1 = graphicalService
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      xmodmap = graphicalService
        "${pkgs.xorg.xmodmap}/bin/xmodmap /home/${username}/.Xmodmap";

      dunst = graphicalService
        "${pkgs.dunst}/bin/dunst -conf /home/${username}/.dunstrc";

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
  services.greetd = with userSettings; {
    enable = true;
    settings = {
      initial_session = {
        command = "${wm.session}";
        user = "${username}";
      };
      default_session = {
        command = "${wm.session}";
        user = "${username}";
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
