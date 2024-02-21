{ pkgs, userSettings }: ''
  exec > "/home/stefan/startup.log" 2>&1  # Redirect stdout and stderr to a log file
  echo "Starting up..."
  ${pkgs.xorg.xrandr}/bin/xrandr --newmode "3440x1440_144.00" 1086.75 3440 3744 4128 4816 1440 1443 1453 1568 -hsync +vsync
  ${pkgs.xorg.xrandr}/bin/xrandr --addmode DisplayPort-0 3440x1440_144.00
  ${pkgs.xorg.xrandr}/bin/xrandr -s 3440x1440 -r 144.0
  ${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-0 --set TearFree on
  ${pkgs.xorg.xrandr}/bin/xrandr --newmode "1080vsync" 138.50 1920 1968 2000 2080 1080 1083 1088 1111 +hsync -vsync
  echo "${pkgs.alacritty}/bin/alacritty --class scratchpad,scratchpad "
  ${pkgs.alacritty}/bin/alacritty --class scratchpad,scratchpad  &
  echo "${pkgs.alacritty}/bin/alacritty -o font.size=36 --class Clock,Clock -e tty-clock -n -s"
  ${pkgs.alacritty}/bin/alacritty -o font.size=36 --class Clock,Clock -e tty-clock -n -s &
  echo "${pkgs.nitrogen}/bin/nitrogen --set-zoom-fill /home/${userSettings.username}/.config/i3/wallpaper.png"
  ${pkgs.nitrogen}/bin/nitrogen --set-zoom-fill /home/${userSettings.username}/.config/i3/wallpaper.png &
  echo "${pkgs.blueman}/bin/blueman-applet"
  ${pkgs.blueman}/bin/blueman-applet &
  echo "${pkgs.picom-jonaburg}/bin/picom
  ${pkgs.picom-jonaburg}/bin/picom &
  echo "${pkgs.flameshot}/bin/flameshot"
  ${pkgs.flameshot}/bin/flameshot &
  echo "${pkgs.xdotool}/bin/xdootool search --name 'autokey-gtk' windowunmap"
  ${pkgs.xdotool}/bin/xdootool search --name \"autokey-gtk\" windowunmap" &
  echo "${pkgs.autokey}/bin/autokey-gtk"
  ${pkgs.autokey}/bin/autokey-gtk &
  echo "${pkgs.xfce.xfce4-power-manager}/bin/xfce4-power-manager"
  ${pkgs.xfce.xfce4-power-manager}/bin/xfce4-power-manager &
  echo "${pkgs.xorg.xsetroot}/bin/xsetroot"
  ${pkgs.xorg.xsetroot}/bin/xsetroot &
''
