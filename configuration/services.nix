{ inputs, pkgs, ... }:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  session = inputs.hyprland.packages."${pkgs.system}".hyprland;
  username = "stefan";
in {

  services = {
    dbus.enable = true;
    printing.enable = true;
    blueman.enable = true;
    flatpak.enable = true;
    openssh.enable = true;
    udisks2.enable = true;
  };
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     initial_session = {
  #       command = "${session}";
  #       user = "${username}";
  #     };
  #     default_session = {
  #       command =
  #         "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time -cmd ${session}";
  #       user = "greeter";
  #     };
  #   };
  # };
  services.udev.packages = [ pkgs.dolphinEmu ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  xdg.portal.wlr.enable = true;

}
