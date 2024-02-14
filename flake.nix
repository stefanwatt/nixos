{
  description = "Main config";
  inputs = {
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    hyprContrib.url = "github:hyprwm/contrib";
  };

  outputs = { self, nixpkgs, anyrun, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules =
        [ ./configuration.nix inputs.home-manager.nixosModules.default ];
    };
  };
}
