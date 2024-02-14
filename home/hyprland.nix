{ pkgs, inputs, ... }:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
  username = "stefan";
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.dbus-sway-environment}/bin/dbus-sway-environment
    ${pkgs.configure-gtk}/bin/configure-gtk
    ${pkgs.systemctl}/bin/systemctl --user import-environment
    ${pkgs.dunst}/bin/dunst -conf ~/.config/sway/dunstrc
    ${pkgs.xsetroot}/bin/xsetroot -cursor_name left_ptr 
    ${pkgs.xfce4-power-manager}/bin/xfce4-power-manager 
    ${pkgs.autokey-gtk}/bin/autokey-gtk
    ${pkgs.alacritty}/bin/alacritty --class scratchpad,scratchpad 
    ${pkgs.alacritty}/bin/alacritty -o font.size=36 --class Clock,Clock -e tty-clock -n -s"}/bin/"alacritty -o font.size=36 --class Clock,Clock -e tty-clock -n -s
    ${pkgs.polkit-gnome-authentication-agent-1}/bin/polkit-gnome-authentication-agent-1
    ${pkgs.udiskie}/bin/udiskie
    ${pkgs.swaybg}/bin/swaybg -m fill -i /home/stefan/.config/sway/wallpaper.png
    ${pkgs.blueman-applet}/bin/blueman-applet
    ${pkgs.pypr}/bin/pypr
  '';
in {
  imports = [ inputs.anyrun.homeManagerModules.default ];
  nixpkgs.overlays = [ inputs.hyprContrib.overlays.default ];

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${session}";
        user = "${username}";
      };
      default_session = {
        command =
          "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time -cmd ${session}";
        user = "greeter";
      };
    };
  };
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  services.dbus.enable = true;
  home.packages = with pkgs; [
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
    (pkgs.python311Packages.buildPythonPackage rec {
      pname = "pyprland";
      version = "1.9.1";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "sha256-vzEny3rEYxRAzLhO3KCgIetGG1JAnz3HJ61ufV2Isjc=";
      };
      format = "pyproject";
      propagatedBuildInputs = with pkgs; [
        python3Packages.setuptools
        python3Packages.poetry-core
        poetry
      ];
      doCheck = false;
    })

  ];
  programs.hyprland.package =
    inputs.hyprland.packages."${pkgs.system}".hyprland;
  wayland.hyprland = {
    enable = true;
    settings = { exec-once = "${startupScript}/bin/start"; };
  };
}
