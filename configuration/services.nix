{ userSettings, pkgs, lib, ... }:
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
  musnix.enable = true;
  services.udisks2.enable = true;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  security.polkit.enable = true;
  security.rtkit.enable = true;
  systemd = {
    user.services = {

      xmodmap = graphicalService
        "${pkgs.xorg.xmodmap}/bin/xmodmap /home/${userSettings.username}/.Xmodmap";
      fcitx5 = {
        description = "Fcitx5 input method daemon";
        wantedBy = [ "multi-user.target" ];
        serviceConfig.ExecStart = "${pkgs.fcitx5}/bin/fcitx5";
      };
      udiskie = {
        description = "udiskie automount service";
        wantedBy = [ "default.target" ];
        serviceConfig = { ExecStart = "${pkgs.udiskie}/bin/udiskie"; };
      };
    };
  };

  environment.systemPackages = with pkgs; [ greetd.greetd greetd.tuigreet ];
  services.greetd = lib.mkIf (userSettings.wm.name == "hyprland")
    (with userSettings; {
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
    });

  services = {
    dbus.enable = true;
    printing.enable = true;
    blueman.enable = true;
    flatpak.enable = true;
    openssh.enable = true;
    # udisks2.enable = true;
  };
  services.udev.packages = [ pkgs.dolphin-emu pkgs.vial pkgs.via ];
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    # wlr.enable = true;
    config.common.default = "*";
  };
}
