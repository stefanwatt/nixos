{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Stefan Watt";
    userEmail = "stefan.watt@gmail.com";
  };
  programs.gh.enable = true;

}
