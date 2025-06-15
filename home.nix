{ pkgs, inputs, userSettings, ... }:
let
  wm = if userSettings.wm.name == "i3" then
    ./home/i3/i3.nix
  else
    ./home/hyprland/hyprland.nix;
in {
  imports = [
    ./home/desktop.nix
    ./home/dev.nix
    ./home/git.nix
    ./home/gtk.nix
    ./home/keymap.nix
    ./home/multimedia.nix
    ./home/scripts/switch-audio-device.nix
    ./home/scripts/fuzzy-find-project.nix
    ./home/vscode.nix
    ./home/nushell.nix
    ./home/zsh.nix
    wm
  ];
  manual.html.enable = false;
  manual.manpages.enable = false;
  fonts.fontconfig.enable = true;
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;
  home.stateVersion = "23.05";
  programs.home-manager = { enable = true; };
}
