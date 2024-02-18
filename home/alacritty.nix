{ userSettings, pkgs, ... }:
let
  normalColors = with userSettings.colors; {
    black = surface0;
    red = red;
    green = green;
    yellow = yellow;
    blue = blue;
    magenta = maroon;
    cyan = sapphire;
    white = text;

  };
in {
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
          family = userSettings.font.mono.name;
          style = "Regular";
        };
        bold = {
          family = userSettings.font.mono.name;
          style = "Bold";
        };
        italic = {
          family = userSettings.font.mono.name;
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

      colors = with userSettings.colors; {
        primary = {
          background = base;
          foreground = text;
          dimForeground = surface0;
        };
        cursor = {
          text = base;
          cursor = text;
        };
        viModeCursor = {
          text = base;
          cursor = text;
        };
        selection = {
          text = "CellForeground";
          background = surface0;
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = sky;
          };
        };
        normal = normalColors;
        bright = normalColors;
        dim = normalColors;

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

        shell = { program = "${pkgs.zsh}/bin/zsh"; };

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
  };
}
