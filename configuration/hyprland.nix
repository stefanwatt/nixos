{ pkgs, ... }:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
  username = "stefan";
in {
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${session}";
        user = "${username}";
      };
      default_session = {
        command =
          "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time -cmd ${session}";
        user = "greeter";
      };
    };
  };
  services.xserver.displayManager.gdm.wayland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  services.dbus.enable = true;
  environment.systemPackages = with pkgs; [
    gnome.gdm
    wlprop
    albert
    wl-clipboard
    wdisplays
    swaybg
    swappy
    greetd.greetd
    greetd.tuigreet
    grim
    grimblast
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    mako
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
  programs.hyprland.enable = true;
}
