{ pkgs, userSettings }: ''
  exec > "/home/stefan/startup.log" 2>&1  # Redirect stdout and stderr to a log file
  echo "Starting up..."
  ${pkgs.xorg.xrandr}/bin/xrandr --newmode "3440x1440_144.00" 1086.75 3440 3744 4128 4816 1440 1443 1453 1568 -hsync +vsync
  ${pkgs.xorg.xrandr}/bin/xrandr --addmode DisplayPort-0 3440x1440_144.00
  ${pkgs.xorg.xrandr}/bin/xrandr -s 3440x1440 -r 144.0
  ${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-0 --set TearFree on
  ${pkgs.xorg.xrandr}/bin/xrandr --newmode "1080vsync" 138.50 1920 1968 2000 2080 1080 1083 1088 1111 +hsync -vsync
  echo "${pkgs.nitrogen}/bin/nitrogen --set-zoom-fill /home/${userSettings.username}/.config/myi3/wallpaper.png"
  ${pkgs.nitrogen}/bin/nitrogen --set-zoom-fill /home/${userSettings.username}/.config/myi3/wallpaper.png &
  echo "${pkgs.xdotool}/bin/xdootool search --name 'autokey-gtk' windowunmap"
  ${pkgs.xdotool}/bin/xdootool search --name \"autokey-gtk\" windowunmap" &
  echo "${pkgs.xorg.xsetroot}/bin/xsetroot"
  ${pkgs.xorg.xsetroot}/bin/xsetroot &
''
