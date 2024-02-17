{ ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        opacity = 0.95;
        padding = {
          x = 0;
          y = 0;
        };
        dynamicPadding = true;
        decorations = "full";
        startupMode = "Windowed";
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      tabspaces = 4;

      font = {
        normal = {
          family = "Victor Mono Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "Victor Mono Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "Victor Mono Nerd Font Mono";
          style = "Italic";
        };
        size = 14.0;
        offset = {
          x = 0;
          y = 0;
        };
        glyphOffset = {
          x = 0;
          y = 0;
        };
      };

      drawBoldTextWithBrightColors = true;

      colors = {
        primary = {
          background = "#2e3440";
          foreground = "#d8dee9";
          dimForeground = "#a5abb6";
        };
        cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        viModeCursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        selection = {
          text = "CellForeground";
          background = "#4c566a";
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = "#88c0d0";
          };
        };
        normal = {
          black = "#3b4252";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#e5e9f0";
        };
        bright = {
          black = "#4c566a";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#8fbcbb";
          white = "#eceff4";
        };
        dim = {
          black = "#373e4d";
          red = "#94545d";
          green = "#809575";
          yellow = "#b29e75";
          blue = "#68809a";
          magenta = "#8c738c";
          cyan = "#6d96a5";
          white = "#aeb3bb";
        };
      };

      visualBell = {
        animation = "EaseOutExpo";
        duration = 0;
        color = "0xffffff";
      };

      selection = {
        semanticEscapeChars = ",│`|:\"'' ()[]{}<>";
        saveToClipboard = false;
      };

      dynamicTitle = true;

      cursor = { unfocusedHollow = true; };

      liveConfigReload = true;

      shell = { program = "/run/current-system/sw/bin/zsh"; };

      workingDirectory = null;

      enableExperimentalConptyBackend = false;

      debug = {
        renderTimer = false;
        persistentLogging = false;
        logLevel = "Warn";
        printEvents = false;
      };

      mouse = {
        doubleClick = { threshold = 300; };
        tripleClick = { threshold = 300; };
        hideWhenTyping = false;
      };

      mouseBindings = [{
        mouse = "Middle";
        action = "PasteSelection";
      }];
    };
  };
}
