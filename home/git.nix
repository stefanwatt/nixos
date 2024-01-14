{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Stefan Watt";
    userEmail = "stefan.watt@gmail.com";
    extraConfig = { core.editor = "vim"; };
  };
  programs.gh.enable = true;

}
