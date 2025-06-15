{
  description = "Adapted Main Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";
    nixpkgs-old.url = "github:NixOS/nixpkgs/release-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    musnix = { url = "github:musnix/musnix"; };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    stylix.url = "github:danth/stylix/cf8b6e2d4e8aca8ef14b839a906ab5eb98b08561";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprContrib.url = "github:hyprwm/contrib";
    hyprland.url = "github:hyprwm/Hyprland?ref=v0.49.0";
    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.49.0";
      inputs.hyprland.follows = "hyprland";
    };
    # lux.url = "git+https://github.com/nvim-neorocks/lux";
  };

  outputs = { self, nixpkgs-old, nixpkgs-unstable, nixpkgs, home-manager
    , flake-utils, ... }@inputs:
    let
      system = "x86_64-linux";
      
      # Import profiles and settings
      profiles = import ./profiles { inherit system; username = "stefan"; };
      inherit (profiles) systemSettings userSettings;
      
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
          doCheck = false;
        };
      };

      pkgs-old = import nixpkgs-old {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
          doCheck = false;
        };
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
          doCheck = false;
        };
      };
    in {
      homeConfigurations = {
        stefan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit pkgs-unstable;
            inherit pkgs-old;
            inherit inputs;
            inherit userSettings;
            inherit systemSettings;
          };
        };
      };

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          modules = [ ./configuration.nix inputs.musnix.nixosModules.musnix ];
          specialArgs = {
            inherit inputs;
            inherit userSettings;
            inherit systemSettings;
            inherit pkgs-unstable;
            inherit pkgs-old;
          };
        };
      };
    };
}

