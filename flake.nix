{
  description = "Adapted Main Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    musnix = { url = "github:musnix/musnix"; };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # flake-utils.follows = "flake-utils";
      };
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
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ssbm = { url = "github:djanatyn/ssbm-nix"; };
    nix-bubblewrap = {
      url = "git+https://git.sr.ht/~fgaz/nix-bubblewrap";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lux.url = "git+https://github.com/nvim-neorocks/lux";
  };

  outputs =
    { self, nixpkgs-unstable, nixpkgs, home-manager, flake-utils, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit (systemSettings) system;
        config = {
          allowUnfree = true;
          # permittedInsecurePackages =
          #   [ "electron-19.1.9" "electron" "windsurf" ];
        };
        overlays = [
          (final: prev: {
            gleam = final.rustPlatform.buildRustPackage rec {
              pname = "gleam";
              version = "1.4.1";

              src = final.fetchFromGitHub {
                owner = "gleam-lang";
                repo = "gleam";
                rev = "v${version}";
                sha256 =
                  "sha256-ncb95NjBH/Nk4XP2QIq66TgY1F7UaOaRIEvZchdo5Kw="; # Update this hash
              };

              cargoHash =
                "sha256-5+LQKCBWXvvJJN0U+t9elSem4WLdoosiEAH4H+4bZ9U="; # Update this hash

              nativeBuildInputs = with final; [ pkg-config ];

              buildInputs = with final; [ openssl ];

              # Disable running the tests as part of the build process
              doCheck = false;

              meta = with final.lib; {
                description =
                  "A friendly language for building type-safe, scalable systems!";
                homepage = "https://gleam.run/";
                license = licenses.asl20;
              };
            };
          })
        ];
      };
      # pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.system};
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

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
        wm = hyprland;
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
          modules = [ ./configuration.nix inputs.musnix.nixosModules.musnix ];
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

