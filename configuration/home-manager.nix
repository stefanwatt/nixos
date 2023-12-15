{ config, pkgs, ... }: {
  home-manager = {
    # useGlobalPkgs = true;
    useUserPackages = true;
    users.stefan = import ../home.nix;
  };
}
