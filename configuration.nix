{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
    ./configuration/boot.nix
    ./configuration/filesystem.nix
    ./configuration/hardware.nix
    ./configuration/home-manager.nix
    ./configuration/overlays.nix
    ./configuration/locale.nix
    ./configuration/networking.nix
    ./configuration/packages.nix
    ./configuration/pipewire.nix
    ./configuration/programs.nix
    ./configuration/security.nix
    ./configuration/services.nix
    ./configuration/settings.nix
    ./configuration/shell.nix
    ./configuration/sway.nix
    ./configuration/system.nix
    ./configuration/systemd.nix
    ./configuration/users.nix
    ./configuration/virtualisation.nix
    # ./configuration/xserver.nix
  ];
}
