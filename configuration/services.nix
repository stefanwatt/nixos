{ userSettings, pkgs, ... }: {
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  security.polkit.enable = true;
  security.rtkit.enable = true;
  systemd = {
    user.services = {
      udiskie = {
        description = "udiskie automount service";
        wantedBy = [ "default.target" ];
        serviceConfig = { ExecStart = "${pkgs.udiskie}/bin/udiskie"; };
      };
    };
  };
  # services.greetd = with userSettings; {
  #   enable = true;
  #   settings = {
  #     initial_session = {
  #       command = "${wm.session}";
  #       user = "${username}";
  #     };
  #     default_session = {
  #       command = "${wm.session}";
  #       user = "${username}";
  #     };
  #   };
  # };

  services = {
    dbus.enable = true;
    printing.enable = true;
    blueman.enable = true;
    flatpak.enable = true;
    openssh.enable = true;
    udisks2.enable = true;
  };
  services.udev.packages = [ pkgs.dolphinEmu pkgs.vial pkgs.via ];
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
