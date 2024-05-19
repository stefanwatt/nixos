{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lutris
    steam-run
    wineWowPackages.stable
    wine
    (wine.override { wineBuild = "wine64"; })
    wineWowPackages.staging
    winetricks
    dolphin-emu
  ];
}
