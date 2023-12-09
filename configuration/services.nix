{ config, pkgs, ... }: {
  services = {
    printing.enable = true;
    blueman.enable = true;
    flatpak.enable = true;
    openssh.enable = true;
  };
  services.udev.packages = [ pkgs.dolphinEmu ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
}
