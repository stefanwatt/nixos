{ pkgs, ... }: {
  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = ["scratchpads"]

    [scratchpads.term]
    command = "alacritty --class scratchpad"
    margin = 50

    [scratchpads.clock]
    command = "alacritty -o font.size=36 --class Clock,Clock -e tty-clock -n -s"
    margin = 50
  '';

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
