{ pkgs, ... }:

let
  unstable = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { };
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };
in {

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-19.1.9" ];
    packageOverrides = pkgs: rec {
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
  environment.systemPackages = with pkgs; [
    lxqt.qps
    python311Packages.pip
    python311Packages.west
    python311Packages.pyelftools
    python311Packages.canopen
    python311Packages.packaging
    python311Packages.progress
    python311Packages.anytree
    python311Packages.intelhex
    python311Packages.pyyaml
    python311Packages.pykwalify
    python311Packages.ruamel-base
    python311Packages.ruamel-yaml
    python311Packages.six
    python311Packages.dateutil
    rclone
    unstable.cosmic-settings
    unstable.cosmic-launcher
    unstable.cosmic-comp
    tmux
    tmuxPlugins.resurrect
    tmuxPlugins.continuum
    unstable.bun
    wuzz
    qtemu
    qemu_full
    niv
    neovim-remote
    xcolor
    vim
    xfce.thunar
    polkit_gnome
    dotnet-sdk
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
    easyeffects
    simplescreenrecorder
    showmethekey
    marksman
    tesseract
    anydesk
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
    udisks2
    icu
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
    xorg.libX11
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
    nodePackages.typescript
    ardour
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
