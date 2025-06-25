{ pkgs, inputs, userSettings, ... }:
let
  mapHyprlandColors = { colors }:
    let
      hexToArgb = name: value: {
        "${"$"}${name}" = "rgb(${builtins.substring 1 6 value})";
      };
    in builtins.foldl' (acc: name: acc // (hexToArgb name colors.${name})) { }
    (builtins.attrNames colors);

  startupScript = import ./startup.nix { inherit pkgs; };
  colorSettings = mapHyprlandColors { colors = userSettings.colors; };
in {
  imports = [ ./systemd.nix ];
  nixpkgs.overlays = [ inputs.hyprContrib.overlays.default ];
  home.packages = with pkgs; [
    xorg.xhost
    xorg.xmodmap
    xorg.xev
    wev
    hyprprop
    gdk-pixbuf
    pango
    cairo
    glib
    gdm
    wlprop
    wl-clipboard
    wdisplays
    swaybg
    swappy
    grim
    grimblast
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    mako
    wezterm
    ghostty
    satty
    slurp
    eww
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    icomoon-feather
    bc
    libnotify
    hyprcursor
    wtype
    cosmic-files
  ];
  home.file."Scripts/go-launch.sh" = {
    source = ../scripts/go-launch.sh;
    executable = true;
  };
  home.pointerCursor = {
    name = "Bibata-Modern-Amber";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    enable = true;
    systemd.enable = true;
    plugins = [ inputs.hy3.packages."${pkgs.system}".hy3 ];
    settings = {
      "$mod" = "SUPER";
      "$font_name" = userSettings.font.mono.name;
      "$font_size" = userSettings.font.mono.size;
      exec-once = [
        "${startupScript}/bin/start"
        "${pkgs.xorg.xmodmap}/bin/xmodmap /home/${userSettings.username}/.Xmodmap"
      ];
      source = [
        "/home/stefan/.config/nixos/home/hyprland/config/general.conf"
        "/home/stefan/.config/nixos/home/hyprland/config/windows.conf"
        "/home/stefan/.config/nixos/home/hyprland/config/keymaps.conf"
        "/home/stefan/.config/nixos/home/hyprland/config/hy3.conf"
      ];
    } // colorSettings;
  };
}
