{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    templ.url = "github:a-h/templ";
  };

  outputs = { self, nixpkgs, templ, ... }@inputs: {
    nixosConfigurations.myConfig = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ (import ./overlays.nix { inherit inputs; }) ];
        })
      ];
    };
  };
}
