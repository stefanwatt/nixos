{ pkgs, ... }: {
  imports = [ ./dunst.nix ./config.nix ./systemd.nix ./startup.nix ];

  home.packages = with pkgs; [
    i3
    polkit_gnome
    autokey
    arandr
    xdotool
    nitrogen
    picom-jonaburg
    rofi
    xfce.xfce4-power-manager
    xclip
    xorg.xkill
    xorg.libX11
    xorg.xsetroot
    xorg.xf86videoamdgpu
    xorg.xinit
  ];
}
