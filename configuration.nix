{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./configuration/dev.nix
    ./configuration/filesystem.nix
    ./configuration/gaming.nix
    # ./configuration/i3.nix
    ./configuration/locale.nix
    ./configuration/multimedia.nix
    ./configuration/networking.nix
    ./configuration/pipewire.nix
    ./configuration/services.nix
    # ./configuration/sway.nix
    ./configuration/users.nix
    ./configuration/virtualisation.nix
  ];

  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-19.1.9" ];
  };

  hardware = {
    firmware = [ pkgs.linux-firmware ];
    opengl = {
      extraPackages = [ pkgs.amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth.enable = true;
    pulseaudio.enable = false;
  };

  boot = {
    initrd.kernelModules = [ "amdgpu" "gcadapter_oc" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    extraModulePackages = [ config.boot.kernelPackages.gcadapter-oc-kmod ];
  };

  nix = {
    settings = {
      substituters =
        [ "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  programs = {
    thunar.enable = true;
    zsh.enable = true;
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
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
    alacritty
    zsh
    xfce.thunar
    ranger
    dolphin-emu
    gparted
    udisks2
    udiskie
    blueman
    rclone
    wget
    iftop
    openssh
    unzip
    xcolor
    wuzz
    etcher
    anydesk
    yt-dlp
    stylua
    fd
    ripgrep
    fzf
    cloc
    tty-clock
    megasync
    p7zip
    rar
    polkit_gnome
    xfce.xfce4-power-manager
    dunst
    autokey
    catppuccin-gtk
    xorg.libxcvt
    xorg.xf86videoati
    xorg.xf86videoamdgpu
  ];

}
