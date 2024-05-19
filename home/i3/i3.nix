{ pkgs, userSettings, ... }: {
  imports = [ ./dunst.nix ./config.nix ./systemd.nix ./startup.nix ];
  gtk.enable = true;
  home.file."/home/${userSettings.username}/Scripts/i3-tabbed-if-not.sh" = {
    text = ''
      #!/run/current-system/sw/bin/bash
      i3_tree=$(i3-msg -t get_tree)
      layout=$(echo "$i3_tree" | jq -r '.. | select(.nodes? // empty | .[] | .focused == true).layout')
      if [[ "$layout" != "tabbed" ]]; then
        focused_window_id=$(echo "$i3_tree" | jq -r '.. | select(type == "object" and .focused == true).id')
        i3-msg "[con_id=$focused_window_id] split h layout tabbed"
      fi
    '';
    force = true;
  };
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
    lxappearance
    xclip
    xorg.xkill
    xorg.libX11
    xorg.xsetroot
    xorg.xf86videoamdgpu
    xorg.xinit
    wezterm
    emoji-picker
  ];
}
