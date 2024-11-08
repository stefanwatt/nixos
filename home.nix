{ pkgs, inputs, userSettings, ... }:
let
  wm = if userSettings.wm.name == "i3" then
    ./home/i3/i3.nix
  else
    ./home/hyprland/hyprland.nix;
in {
  nixpkgs.overlays = [ inputs.templ.overlays.default ];
  imports = [
    ./home/anyrun.nix
    ./home/git.nix
    ./home/gleam.nix
    ./home/gtk.nix
    ./home/keymap.nix
    ./home/neovim.nix
    ./home/nodejs.nix
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
  home.packages = with pkgs; [
    templ
    btop
    rustup
    (pkgs.nerdfonts.override {
      fonts = [ "VictorMono" "DroidSansMono" "FiraCode" ];
    })
  ];
  programs.home-manager = { enable = true; };
}
