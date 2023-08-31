{ config, pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-12.2.3" ];
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
    python39
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
    bun
    luajitPackages.jsregexp
    nodePackages.typescript-language-server
    gnumake
    sqlite
    dbeaver
    neovide
    brave
    go
    air
    jetbrains.goland
    supabase-cli
    gnome.gnome-keyring
    docker
    yarn
    xorg.xf86videoati
    xorg.xf86videoamdgpu
    postgresql
    discord
    libreoffice
    unzip
  ];
}
