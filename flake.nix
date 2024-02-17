{
  description = "Main config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    hyprContrib.url = "github:hyprwm/contrib";
    hyprland.url = "github:hyprwm/Hyprland?ref=v0.35.0";
    flake-utils.url = "github:numtide/flake-utils";
    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.35.0";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { self, nixpkgs, anyrun, hyprland, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules =
        [ ./configuration.nix inputs.home-manager.nixosModules.default ];
    };
  };
}
