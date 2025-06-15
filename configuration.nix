{ config, userSettings, pkgs, ... }:
let wmModule = import ./modules/wm { inherit userSettings; };
in {
  imports = [
    ./hardware-configuration.nix
    ./configuration/dev.nix
    ./configuration/filesystem.nix
    # ./configuration/gaming.nix
    ./configuration/locale.nix
    ./configuration/networking.nix
    ./configuration/pipewire.nix
    ./configuration/services.nix
    ./configuration/stylix.nix
    ./configuration/users.nix
    ./configuration/virtualisation.nix
    # ./configuration/home-assistant.nix
  ] ++ wmModule.wmSystemImports;

  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;

  nixpkgs.config = {
    doCheck = false;
    allowUnfree = true;
    allowBroken = true;
  };

  hardware = {
    firmware = [ pkgs.linux-firmware ];
    graphics = {
      package = pkgs.mesa;
      enable = true;
      extraPackages = [ pkgs.amdvlk ];
    };
    bluetooth.enable = true;
  };

  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;
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
      trusted-users = [ "root" userSettings.username ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" # Add this line
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
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
    gnome-keyring
    home-manager
    udisks2
    udiskie
    wget
    openssh
    polkit_gnome
  ];
  programs.fuse.userAllowOther = true;
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/10 * * * * stefan /home/${userSettings.username}/.config/eww/scripts/weather.sh --getdata"
    ];
  };
}
