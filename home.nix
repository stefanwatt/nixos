{ config, pkgs, ... }:

{
  imports = [
    ./home/vscode.nix
    ./home/cursor.nix
    ./home/firefox.nix
    ./home/git.nix
    ./home/neovim.nix
    ./home/zsh.nix
    ./home/gtk.nix
  ];

  fonts.fontconfig.enable = true;
  home.username = "stefan";
  home.homeDirectory = "/home/stefan";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    btop
    rustup
    (pkgs.nerdfonts.override { fonts = [ "VictorMono" "DroidSansMono" ]; })
  ];
}
