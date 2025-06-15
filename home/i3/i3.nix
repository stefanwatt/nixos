{ pkgs, pkgs-unstable, userSettings, ... }: {
  imports = [ ./dunst.nix ./config.nix ./systemd.nix ./startup.nix ];
  home.pointerCursor = let
    getFrom = url: hash: name: {
      gtk.enable = true;
      x11.enable = true;
      name = name;
      size = 48;
      package = pkgs.runCommand "moveUp" { } ''
        mkdir -p $out/share/icons
        ln -s ${
          pkgs.fetchzip {
            url = url;
            hash = hash;
          }
        } $out/share/icons/${name}
      '';
    };
  in getFrom
  "https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.6/Bibata-Modern-Ice.tar.gz"
  "sha256-BvVE9qupMjw7JRqFUj1J0a4ys6kc9fOLBPx2bGaapTk=" "Bibata-Modern-Ice";
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
  home.packages = with pkgs;
    [
      flameshot
      i3
      polkit_gnome
      autokey
      arandr
      xdotool
      nitrogen
      picom
      rofi
      xfce.xfce4-power-manager
      lxappearance
      xclip
      xorg.xkill
      xorg.libX11
      xorg.xsetroot
      xorg.xf86videoamdgpu
      xorg.xinit
      emoji-picker
      xorg.libxcvt
      xorg.xf86videoati
      xcolor
    ] ++ (with pkgs-unstable; [ wezterm ]);
}
