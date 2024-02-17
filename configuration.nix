{ ... }: {
  imports = [

    ./hardware-configuration.nix
    ./configuration/boot.nix
    ./configuration/dev.nix
    ./configuration/filesystem.nix
    ./configuration/gaming.nix
    ./configuration/hardware.nix
    # ./configuration/i3.nix
    ./configuration/locale.nix
    ./configuration/multimedia.nix
    ./configuration/networking.nix
    ./configuration/packages.nix
    ./configuration/pipewire.nix
    ./configuration/programs.nix
    ./configuration/services.nix
    # ./configuration/sway.nix
    ./configuration/users.nix
    ./configuration/utilities.nix
    ./configuration/virtualisation.nix
  ];
  nix = {
    settings = {
      substituters =
        [ "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
