{ pkgs, inputs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-19.1.9" ];
  };
  environment.systemPackages = with pkgs; [
    (inputs.anyrun.packages.${pkgs.system}.anyrun)
    firefox
    # chromium
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
