{ userSettings, pkgs, ... }: {

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
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  xdg.portal.wlr.enable = true;

}
