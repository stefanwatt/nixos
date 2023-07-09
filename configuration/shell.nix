{ config, pkgs, ... }: {
  users.users.stefan.shell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
}
