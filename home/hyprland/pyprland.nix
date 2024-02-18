{ pkgs, userSettings, ... }:
let path = with userSettings; "/home/${username}/.config/hypr/pyprland.toml";
in {
  home.file."${path}" = {
    text = ''
      [pyprland]
      plugins = ["scratchpads"]

      [scratchpads.autokey]
      command = "${pkgs.autokey}/bin/autokey-gtk"
      margin = 50

      [scratchpads.term]
      command = "${pkgs.alacritty}/bin/alacritty --class scratchpad,scratchpad"
      margin = 50

      [scratchpads.clock]
      command = "${pkgs.alacritty}/bin/alacritty -o font.size=36 --class Clock,Clock -e tty-clock -n -s"
      margin = 50
    '';
    force = true;
  };
  home.packages = with pkgs;
    [
      (pkgs.python311Packages.buildPythonPackage rec {
        pname = "pyprland";
        version = "1.9.1";
        src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-vzEny3rEYxRAzLhO3KCgIetGG1JAnz3HJ61ufV2Isjc=";
        };
        format = "pyproject";
        propagatedBuildInputs = with pkgs; [
          python3Packages.setuptools
          python3Packages.poetry-core
          poetry
        ];
        doCheck = false;
      })
    ];
}
