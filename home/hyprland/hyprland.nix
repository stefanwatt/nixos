{ pkgs, inputs, userSettings, ... }:
let
  startupScript = import ./startup.nix { inherit pkgs; };
  colorSettings = import ./colors.nix { colors = userSettings.colors; };
in {
  imports = [ ./pyprland.nix ];
  nixpkgs.overlays = [ inputs.hyprContrib.overlays.default ];
  home.packages = with pkgs; [
    xorg.xhost
    autokey
    hyprprop
    gtk3
    gdk-pixbuf
    pango
    cairo
    glib
    gnome.gdm
    wlprop
    albert
    wl-clipboard
    wdisplays
    swaybg
    swappy
    greetd.greetd
    greetd.tuigreet
    grim
    grimblast
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    mako
  ];
  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    enable = true;
    systemd.enable = true;
    plugins = [ inputs.hy3.packages."${pkgs.system}".hy3 ];
    settings = {
      "$font_name" = userSettings.font.mono.name;
      "$font_size" = userSettings.font.mono.size;
      exec-once = "${startupScript}/bin/start";
      source = [
        "/home/stefan/.config/nixos/home/hyprland/config/general.conf"
        "/home/stefan/.config/nixos/home/hyprland/config/windows.conf"
        "/home/stefan/.config/nixos/home/hyprland/config/keymaps.conf"
        "/home/stefan/.config/nixos/home/hyprland/config/hy3.conf"
      ];
    } // colorSettings;
  };
}
