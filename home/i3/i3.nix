{ pkgs, userSettings, ... }:
let
  luaConfigPaths = with userSettings;
    "/home/${username}/.config/nvim/lua/config/paths.lua";
  startupScript = import ./startup.nix {
    inherit pkgs;
    inherit userSettings;
  };

  graphicalService = execStart: {
    Unit = {
      Description = execStart;
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = {
      Type = "simple";
      ExecStart = execStart;
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
      Environment =
        [ "DISPLAY=:0" "PATH=${pkgs.ps}/bin:/run/current-system/sw/bin" ];
    };
  };

  mapI3Colors = { colors }:
    let colorToI3Var = name: value: "set \$${name} ${value}";
    in builtins.concatStringsSep "\n"
    (map (name: colorToI3Var name colors.${name}) (builtins.attrNames colors));
  colorVars = mapI3Colors { colors = userSettings.colors; };

in {
  home.file."/home/${userSettings.username}/.xinitrc" = {
    text = ''
      exec ${pkgs.i3}/bin/i3
    '';
    force = true;
  };
  home.file."/home/${userSettings.username}/.i3-startup" = {
    text = ''
      ${startupScript}
    '';
    force = true;
  };

  home.file."${luaConfigPaths}" = {
    text = ''
      ---@class Config.Paths
      ---@field wm_config string
      local M = {
        wm_config = "${userSettings.wm.configFilePath}",
      }
      return M
    '';
    force = true;
  };
  home.file."/home/${userSettings.username}/.dunstrc" = {
    text = with userSettings.colors; ''
      [global]
      font = Source Code Pro Medium 10
      markup = full
      format = "%s\n%b"
      sort = no
      indicate_hidden = yes
      alignment = left
      show_age_threshold = 60
      word_wrap = yes
      ignore_newline = no
      stack_duplicates = false
      hide_duplicate_count = yes
      geometry = "280x50-10+44"
      shrink = no
      idle_threshold = 120
      monitor = 0
      follow = mouse
      sticky_history = yes
      history_length = 20
      show_indicators = no
      line_height = 4
      separator_height = 4
      padding = 20
      horizontal_padding = 20
      separator_color = auto
      startup_notification = true
      browser = x-www-browser -new-tab
      always_run_script = true
      title = Dunst
      class = Dunst
      icon_position = left
      max_icon_size = 48
      frame_width = 2

      [shortcuts]
      close = ctrl+shift+space
      close_all = ctrl+shift+space
      history = ctrl+grave
      context = ctrl+shift+period

      [urgency_low]
      frame_color = "${lavender}"
      foreground = "${text}"
      background = "${base}"
      timeout = 5

      [urgency_normal]
      frame_color = "#4C566A"
      foreground = "#D8DEE9"
      background = "#2E3440"
      timeout = 5

      [urgency_critical]
      frame_color = "#BF616A"
      foreground = "#BF616A"
      background = "#2E3440"
      timeout = 5
    '';
    force = true;
  };
  systemd.user.services = with userSettings; {
    dunst = graphicalService
      "${pkgs.dunst}/bin/dunst -conf /home/${username}/.dunstrc";
    picom = graphicalService
      "${pkgs.picom-jonaburg}/bin/picom --config /home/${username}/.config/nixos/home/i3/config/picom.conf";
    go-launch = graphicalService
      "/home/${username}/Projects/go-launch/build/bin/go-launch";
    power-manager = graphicalService
      "${pkgs.xfce.xfce4-power-manager}/bin/xfce4-power-manager";
    autokey = graphicalService "${pkgs.autokey}/bin/autokey-gtk";
    flameshot = graphicalService "${pkgs.flameshot}/bin/flameshot";
    blueman = graphicalService "${pkgs.blueman}/bin/blueman-applet";
    clock = graphicalService
      "${pkgs.alacritty}/bin/alacritty -o font.size=36 --class Clock,Clock -e tty-clock -n -s";
    scratchpad = graphicalService
      "${pkgs.alacritty}/bin/alacritty --class scratchpad,scratchpad";
    polkit = graphicalService
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";

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
    xclip
    xorg.xkill
    xorg.libX11
    xorg.xsetroot
    xorg.xf86videoamdgpu
    xorg.xinit
  ];

  home.file."/home/${userSettings.username}/.config/i3/config" = {
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
      set $terminal "alacritty"
      client.focused ${lavender} ${transparent} ${text} ${peach} ${lavender}
      client.focused_inactive ${lavender} ${transparent} ${text} ${peach} ${lavender}
      client.unfocused ${base} ${transparent} ${text} ${peach} ${surface0}
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
