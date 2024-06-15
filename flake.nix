{
  description = "Adapted Main Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    hyprContrib.url = "github:hyprwm/contrib";
    hyprland.url = "github:hyprwm/Hyprland?ref=v0.35.0";
    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.35.0";
      inputs.hyprland.follows = "hyprland";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    templ = {
      url = "github:a-h/templ";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ssbm = { url = "github:djanatyn/ssbm-nix"; };
    nix-bubblewrap = {
      url = "git+https://git.sr.ht/~fgaz/nix-bubblewrap";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs-unstable, nixpkgs, home-manager, ... }@inputs:
    let
      pkgs = import nixpkgs {
        inherit (systemSettings) system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "electron-19.1.9" ];
        };
      };
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.system};

      systemSettings = { system = "x86_64-linux"; };
      hyprland = {
        name = "hyprland";
        configFilePath = "~/.config/nixos/home/hyprland/hyprland.nix";
        session = inputs.hyprland.packages."${pkgs.system}".hyprland
          + "/bin/Hyprland";

      };
      i3 = {
        name = "i3";
        configFilePath = "~/.config/myi3/config";
        session = "startx ~/.xinitrc ${pkgs.i3}/bin/i3";
      };

      userSettings = {
        username = "stefan";
        wm = i3;
        font = {
          mono = {
            name = "Victor Mono Nerd Font Mono";
            size = 12;
          };
          regular = {
            name = "DevaVu Sans";
            size = 12;
          };
        };
        colors = {
          transparent = "#01000000";
          rosewater = "#f2d5cf";
          flamingo = "#eebebe";
          pink = "#f4b8e4";
          mauve = "#ca9ee6";
          red = "#e78284";
          maroon = "#ea999c";
          peach = "#ef9f76";
          yellow = "#e5c890";
          green = "#a6d189";
          teal = "#81c8be";
          sky = "#99d1db";
          sapphire = "#85c1dc";
          blue = "#8caaee";
          lavender = "#babbf1";
          text = "#c6d0f5";
          subtext1 = "#b5bfe2";
          subtext0 = "#a5adce";
          overlay2 = "#949cbb";
          overlay1 = "#838ba7";
          overlay0 = "#737994";
          surface2 = "#626880";
          surface1 = "#51576d";
          surface0 = "#414559";
          base = "#303446";
          mantle = "#292c3c";
          crust = "#232634";
        };
      };
    in {
      homeConfigurations = {
        stefan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit pkgs-unstable;
            inherit inputs;
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
            inherit pkgs-unstable;
          };
        };
      };
    };
}

