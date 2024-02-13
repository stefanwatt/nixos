{ inputs, ... }: {
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    # useGlobalPkgs = true;
    useUserPackages = true;
    users.stefan = import ../home.nix;
  };
}
