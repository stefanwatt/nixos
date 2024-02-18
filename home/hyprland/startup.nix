{ pkgs }:
pkgs.writeShellScriptBin "start" ''
  exec > "/home/stefan/startup.log" 2>&1  # Redirect stdout and stderr to a log file
  echo "Starting up..."
  echo "systemctl --user import-environment"
  systemctl --user import-environment &
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
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
''
