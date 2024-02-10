{ pkgs, ... }: {
  imports = [
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
  home.username = "stefan";
  home.homeDirectory = "/home/stefan";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    btop
    rustup
    (pkgs.nerdfonts.override { fonts = [ "VictorMono" "DroidSansMono" ]; })
  ];
  programs.home-manager.enable = true;
}
