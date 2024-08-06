{ config, userSettings, pkgs, pkgs-unstable, ... }: {
  imports = let
    xserver = if userSettings.wm.name == "i3" then
      [ ./configuration/xserver.nix ]
    else
      [ ];
  in [
    ./hardware-configuration.nix
    ./configuration/dev.nix
    ./configuration/filesystem.nix
    ./configuration/gaming.nix
    ./configuration/locale.nix
    ./configuration/multimedia.nix
    ./configuration/networking.nix
    ./configuration/pipewire.nix
    ./configuration/services.nix
    ./configuration/stylix.nix
    ./configuration/users.nix
    ./configuration/virtualisation.nix
  ] ++ xserver;

  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-19.1.9" ];
  };

  hardware = {
    firmware = [ pkgs.linux-firmware ];
    opengl = {
      enable = true;
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
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
      magicOrExtension = "\\x7fELF....AI\\x02";
    };
  };

  nix = {
    extraOptions = ''
      warn-dirty = false
    '';
    settings = {
      auto-optimise-store = true;
      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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

  environment.systemPackages = (with pkgs; [
    i3
    firefox
    chromium
    brave
    discord
    telegram-desktop
    qbittorrent
    signal-desktop
    remmina
    libreoffice
    dbeaver-bin
    gnome.gnome-keyring
    cloc
    home-manager
    megasync
    jmtpfs
    tty-clock
    alacritty
    zsh
    xfce.thunar
    lxqt.qps
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
    # anydesk
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
    dunst
    jq
    catppuccin-gtk
    xorg.libxcvt
    xorg.xf86videoati
    xorg.xf86videoamdgpu
    ps
    fuse-common
    appimage-run
    libGL
    libGLU
    mods
    qdirstat
    pinta
  ]) ++ (with pkgs-unstable; [ input-remapper yazi ]);

}
