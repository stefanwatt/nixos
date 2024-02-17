{ pkgs, inputs, userSettings, ... }: {
  nixpkgs.overlays = [ inputs.templ.overlay ];
  imports = [
    ./home/anyrun.nix
    ./home/alacritty.nix
    ./home/scripts/switch-audio-device.nix
    ./home/hyprland/hyprland.nix
    ./home/cursor.nix
    ./home/git.nix
    ./home/gtk.nix
    ./home/neovim.nix
    ./home/nodejs.nix
    ./home/vscode.nix
    ./home/zsh.nix
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
    (pkgs.nerdfonts.override { fonts = [ "VictorMono" "DroidSansMono" ]; })
  ];
  programs.home-manager = { enable = true; };
}
