{ pkgs, ... }: {

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-19.1.9" ];
    packageOverrides = pkgs: rec {
      nur = import (builtins.fetchTarball
        "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
    };
  };
  environment.systemPackages = with pkgs; [
    firefox
    chromium
    brave
    discord
    telegram-desktop
    qbittorrent
    signal-desktop
    remmina
    libreoffice
    dbeaver
    gnome.gnome-keyring
    cloc
    home-manager
    megasync
    i3
    nitrogen
    jmtpfs
    tty-clock
  ];
}
