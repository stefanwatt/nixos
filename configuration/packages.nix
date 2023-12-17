{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-19.1.9" ];
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball
        "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
    };
    overlays = [
      (import (builtins.fetchTarball {
        url =
          "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
      }))
    ];
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    xfce.thunar
    polkit_gnome
    firefox
    neovim
    wget
    alacritty
    zsh
    nitrogen
    i3
    flameshot
    lutris
    python311Full
    fnm
    gh
    gcc9
    ninja
    dtc
    cmake
    SDL2
    picom-jonaburg
    lazygit
    rofi
    pavucontrol
    pulseaudio
    pulseaudio-ctl
    ranger
    ponymix
    ripgrep
    arandr
    xclip
    git
    nodejs_20
    blueman
    nixfmt
    xorg.xkill
    etcher
    gparted
    udiskie
    fd
    luajitPackages.luarocks-nix
    unzip
    lua-language-server
    dunst
    spotify
    xfce.xfce4-power-manager
    autokey
    xdotool
    catppuccin-gtk
    stylua
    chromium
    vscode
    neofetch
    openshot-qt
    audacity
    vlc
    luajitPackages.jsregexp
    nodePackages.typescript-language-server
    gnumake
    sqlite
    dbeaver
    neovide
    brave
    go
    air
    gnome.gnome-keyring
    docker
    yarn
    xorg.xf86videoati
    xorg.xf86videoamdgpu
    postgresql
    discord
    libreoffice
    unzip
    dolphin-emu
    p7zip
    rar
    wineWowPackages.stable
    wine
    (wine.override { wineBuild = "wine64"; })
    wineWowPackages.staging
    winetricks
    telegram-desktop
    qbittorrent
    iftop
    fzf
    node2nix
    gimp
    xorg.libxcvt
    jmtpfs
    virtualbox
    signal-desktop
    openssh
    remmina
    yt-dlp
    cloc
    tty-clock
    infamousPlugins
    x42-plugins
    cura
    home-manager
    megasync
    temurin-bin
    maven
  ];
}
