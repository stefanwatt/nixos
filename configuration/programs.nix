{ config, pkgs, ... }: {
  programs = {
    thunar.enable = true;
    zsh.enable = true;
    dconf.enable = true;
  };
}
