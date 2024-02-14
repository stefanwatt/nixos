{ pkgs, inputs, ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    exec > "/home/stefan/startup.log" 2>&1  # Redirect stdout and stderr to a log file
    echo "Starting up..."
    echo "systemctl --user import-environment"
    systemctl --user import-environment &
    echo "${pkgs.dunst}/bin/dunst -conf ~/.config/sway/dunstrc"
    ${pkgs.dunst}/bin/dunst -conf ~/.config/sway/dunstrc &
    echo "${pkgs.autokey}/bin/autokey-gtk"
    ${pkgs.autokey}/bin/autokey-gtk &
    echo "${pkgs.alacritty}/bin/alacritty --class scratchpad,scratchpad "
    ${pkgs.alacritty}/bin/alacritty --class scratchpad,scratchpad  &
    echo "${pkgs.alacritty}/bin/alacritty -o font.size=36 --class Clock,Clock -e tty-clock -n -s"
    ${pkgs.alacritty}/bin/alacritty -o font.size=36 --class Clock,Clock -e tty-clock -n -s &
    echo "${pkgs.polkit_gnome}/bin/polkit-gnome-authentication-agent-1"
    ${pkgs.polkit_gnome}/bin/polkit-gnome-authentication-agent-1 &
    echo "${pkgs.udiskie}/bin/udiskie"
    ${pkgs.udiskie}/bin/udiskie &
    echo "${pkgs.swaybg}/bin/swaybg -m fill -i /home/stefan/.config/hypr/wallpaper.png"
    ${pkgs.swaybg}/bin/swaybg -m fill -i /home/stefan/.config/hypr/wallpaper.png &
    echo "${pkgs.blueman}/bin/blueman-applet"
    ${pkgs.blueman}/bin/blueman-applet &
    echo "${pkgs.xorg.xhost}/bin/xhost +local:"
    ${pkgs.xorg.xhost}/bin/xhost +local: &
    echo "${pkgs.pyprland}/bin/pypr"
    ${pkgs.pyprland}/bin/pypr &
  '';
in {
  nixpkgs.overlays = [ inputs.hyprContrib.overlays.default ];
  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = ["scratchpads"]

    [scratchpads.term]
    command = "alacritty --class scratchpad"
    margin = 50

    [scratchpads.clock]
    command = "alacritty -o font.size=36 --class Clock,Clock -e tty-clock -n -s"
    margin = 50
  '';

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
  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    enable = true;
    settings = {
      source = "/home/stefan/.config/my-hypr/hyprland.conf";
      exec-once = "${startupScript}/bin/start";
    };
  };
}
