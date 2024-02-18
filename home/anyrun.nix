{ userSettings, inputs, pkgs, ... }:
let config_path = with userSettings; "/home/${username}/.config/my-anyrun/";
in {

  imports = [ inputs.anyrun.homeManagerModules.default ];
  nixpkgs.overlays = [
    (self: super: { anyrun = inputs.anyrun.packages.${pkgs.system}.anyrun; })
  ];

  home.file."${config_path}/config.ron" = {
    text = ''
      Config(
        x: Fraction(0.500000),
        y: Fraction(0.400000),
        width: Fraction(0.2500000),
        height: Absolute(0),
        hide_icons: false,
        ignore_exclusive_zones: false,
        layer: Overlay,
        hide_plugin_info: false,
        close_on_click: false,
        show_results_immediately: false,
        max_entries: None,
        plugins: [
          "${inputs.anyrun.packages.${pkgs.system}.rink}/lib/librink.so",
          "${
            inputs.anyrun.packages.${pkgs.system}.translate
          }/lib/libtranslate.so",
          "${
            inputs.anyrun.packages.${pkgs.system}.applications
          }/lib/libapplications.so",
        ],
      )

    '';
    force = true;
  };

  home.file."${config_path}/style.css" = {
    text = with userSettings.colors; ''
      #window {
        background-color: rgba(0, 0, 0, 0.4);
        color: ${text};
        font-family: "${userSettings.font.regular.name}", sans-serif;
      }

      entry#entry {
        border-radius: 10px 10px 0px 0px;
        border-top: 1px solid ${lavender};
        border-left: 1px solid ${lavender};
        border-right: 1px solid ${lavender};
        min-height: 40px;
        background: ${surface0};
        padding: 5px 30px;
        box-shadow: none;
        color: ${text};
      }

      list#main {
        border-radius: 0px 0px 10px 10px;
        border-bottom: 1px solid ${lavender};
        border-left: 1px solid ${lavender};
        border-right: 1px solid ${lavender};
        padding: 5px 25px;
        background: ${surface0};
      }

      #plugin {
        background: transparent;
        padding-bottom: 5px;
        color: ${subtext1};
      }

      #match {
        padding: 2.5px;
        color: ${text};
      }

      #match:selected {
        background: transparent;
        border-radius: 4px;
      }

      #match label#info {
        color: transparent;
      }

      #match:hover {
        background: transparent;
      }

      label#match-desc {
        font-size: 10px;
        color: ${text};
      }

      label#plugin {
        font-size: 11px;
      }
    '';
    force = true;
  };

  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        inputs.anyrun.packages.${pkgs.system}.rink
        inputs.anyrun.packages.${pkgs.system}.translate
        inputs.anyrun.packages.${pkgs.system}.applications
      ];
      width = { fraction = 0.3; };
      ignoreExclusiveZones = false;
      layer = "top";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;
    };
  };
}

