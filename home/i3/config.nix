{ pkgs, userSettings, ... }:
let path = "/home/${userSettings.username}/.config/i3/config";
in {
  home.file."${path}" = {
    text = with userSettings.colors; ''
      set $base ${base}
      set $blue ${blue}
      set $crust ${crust}
      set $flamingo ${flamingo}
      set $green ${green}
      set $lavender ${lavender}
      set $mantle ${mantle}
      set $maroon ${maroon}
      set $mauve ${mauve}
      set $overlay0 ${overlay0}
      set $overlay1 ${overlay1}
      set $overlay2 ${overlay2}
      set $peach ${peach}
      set $pink ${pink}
      set $red ${red}
      set $rosewater ${rosewater}
      set $sapphire ${sapphire}
      set $sky ${sky}
      set $subtext0 ${subtext0}
      set $subtext1 ${subtext1}
      set $surface0 ${surface0}
      set $surface1 ${surface1}
      set $surface2 ${surface2}
      set $teal ${teal}
      set $text ${text}
      set $yellow ${yellow}
      set $alt Mod1
      set $mod Mod4
      set $ws1 "1"
      set $ws2 "2"
      set $ws3 "3"
      set $ws4 "4"
      set $ws5 "5"
      set $ws6 "6"
      set $ws7 "7"
      set $ws8 "8"
      set $ws9 "9"
      set $ws10 "0"
      set $browser "brave"
      set $terminal "wezterm"
      client.focused ${lavender} ${lavender} ${text} ${peach} ${lavender}
      client.focused_inactive ${lavender} ${transparent} ${text} ${peach} ${lavender}
      client.unfocused ${base} ${surface0} ${text} ${peach} ${surface0}
      client.urgent ${red} ${transparent} ${text} ${peach} ${red}
      client.placeholder ${base} ${transparent} ${text} ${peach} ${surface0}
      client.background ${transparent}

      include ~/.config/nixos/home/i3/config/appearance.conf
      include ~/.config/nixos/home/i3/config/behaviour.conf
      include ~/.config/nixos/home/i3/config/keybindings.conf
      include ~/.config/nixos/home/i3/config/windows.conf
      include ~/.config/nixos/home/i3/config/workspaces.conf
      exec --no-startup-id ${pkgs.bash}/bin/bash /home/${userSettings.username}/.i3-startup
      exec --no-startup-id i3-msg workspace $ws2
    '';
    force = true;
  };
}
