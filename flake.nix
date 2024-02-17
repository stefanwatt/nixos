{
  description = "Adapted Main Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    hyprContrib.url = "github:hyprwm/contrib";
    hyprland.url = "github:hyprwm/Hyprland?ref=v0.35.0";
    anyrun.url = "github:Kirottu/anyrun";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      systemSettings = { system = "x86_64-linux"; };

      userSettings = {
        username = "stefan";
        wm = "hyprland";
      };

      pkgs = import nixpkgs {
        inherit (systemSettings) system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "electron-19.1.9" ];
        };
      };

    in {
      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          useUserPackages = true;
          extraSpecialArgs = {
            inherit userSettings;
            inherit systemSettings;
          };
        };
      };

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          modules = [ ./configuration.nix ];
          specialArgs = {
            inherit inputs;
            inherit userSettings;
            inherit systemSettings;
          };
        };
      };
    };
}
