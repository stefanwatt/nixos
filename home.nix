{ pkgs, userSettings, ... }: {
  imports = [
    ./home/anyrun.nix
    ./home/alacritty.nix
    ./home/scripts.nix
    ./home/hyprland/hyprland.nix
    ./home/cursor.nix
    ./home/fzf.nix
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
    btop
    rustup
    (pkgs.nerdfonts.override { fonts = [ "VictorMono" "DroidSansMono" ]; })
  ];
  programs.home-manager = { enable = true; };
}
