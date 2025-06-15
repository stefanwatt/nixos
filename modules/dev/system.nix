{ pkgs, pkgs-unstable, userSettings, ... }:
let
  lib = import ../../lib { inherit pkgs userSettings; };
in {
  # System-level development configuration
  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };
  
  users.users.${userSettings.username}.shell = pkgs-unstable.zsh;
  environment.shells = with pkgs; [ zsh ];
  
  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "100000";
  }];

  # Core development tools
  environment.systemPackages = with pkgs; [
    vim
    neofetch
    git
    lazygit
    cmake
    kitty
    pkg-config
    webkitgtk_4_1
    webkitgtk_6_0
  ];
}