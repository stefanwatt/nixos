{ config, pkgs, ... }: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    <home-manager/nixos>
    ./configuration/boot.nix
    ./configuration/docker.nix
    ./configuration/hardware.nix
    ./configuration/home-manager.nix
    ./configuration/locale.nix
    ./configuration/networking.nix
    ./configuration/overlays.nix
    ./configuration/packages.nix
    ./configuration/pipewire.nix
    ./configuration/programs.nix
    ./configuration/security.nix
    ./configuration/services.nix
    ./configuration/settings.nix
    ./configuration/shell.nix
    ./configuration/system.nix
    ./configuration/systemd.nix
    ./configuration/users.nix
    ./configuration/xserver.nix
  ];
}
