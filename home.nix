{ pkgs, inputs, userSettings, ... }:
let
  wmModule = import ./modules/wm { inherit userSettings; };
in {
  imports = [
    ./home/desktop.nix
    ./home/dev.nix
    ./home/git.nix
    ./home/gtk.nix
    ./home/keymap.nix
    ./home/multimedia.nix
    ./home/scripts/fuzzy-find-project.nix
    ./modules/audio
    ./home/vscode.nix
    ./home/nushell.nix
    ./home/zsh.nix
    wmModule.wmImportPath
  ];
  manual.html.enable = false;
  manual.manpages.enable = false;
  fonts.fontconfig.enable = true;
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;
  home.stateVersion = "23.05";
  programs.home-manager = { enable = true; };
}
