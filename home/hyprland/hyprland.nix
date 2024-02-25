{ pkgs, inputs, userSettings, ... }:
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
  imports = [ ./pyprland.nix ];
  nixpkgs.overlays = [ inputs.hyprContrib.overlays.default ];
  home.packages = with pkgs; [
    xorg.xhost
    xorg.xmodmap
    xorg.xev
    wev
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
  systemd.user.services = with userSettings; {
    xmodmap = graphicalService
      "${pkgs.xorg.xmodmap}/bin/xmodmap /home/${username}/.Xmodmap";
    greetd = with userSettings; {
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

  };
  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    enable = true;
    systemd.enable = true;
    plugins = [ inputs.hy3.packages."${pkgs.system}".hy3 ];
    settings = {
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
