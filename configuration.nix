{ ... }: {
  imports = [

    ./hardware-configuration.nix
    ./configuration/boot.nix
    ./configuration/dev.nix
    ./configuration/filesystem.nix
    ./configuration/gaming.nix
    ./configuration/hardware.nix
    ./configuration/home-manager.nix
    ./configuration/locale.nix
    ./configuration/multimedia.nix
    ./configuration/networking.nix
    ./configuration/packages.nix
    ./configuration/pipewire.nix
    ./configuration/programs.nix
    ./configuration/security.nix
    ./configuration/services.nix
    ./configuration/settings.nix
    ./configuration/shell.nix
    # ./configuration/sway.nix
    ./configuration/hyprland.nix
    ./configuration/system.nix
    ./configuration/systemd.nix
    ./configuration/users.nix
    ./configuration/utilities.nix
    ./configuration/virtualisation.nix
    # ./configuration/xserver.nix
  ];
}
