{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lutris
    wineWowPackages.stable
    wine
    (wine.override { wineBuild = "wine64"; })
    wineWowPackages.staging
    winetricks
    dolphin-emu
  ];
}
