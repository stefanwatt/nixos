{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    steam-run
    # wine related packages commented out as placeholders
    # wineWowPackages.stable
    # wine
    # (wine.override { wineBuild = "wine64"; })
    # wineWowPackages.staging
    # winetricks
    dolphin-emu
  ];
}
