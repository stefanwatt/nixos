{ userSettings, ... }:
let path = "/home/${userSettings.username}/.dunstrc";
in {
  home.file."${path}" = {
    text = with userSettings.colors; ''
      [global]
      font = ${userSettings.font.regular.name} 10
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
}
