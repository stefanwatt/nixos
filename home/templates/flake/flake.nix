{
  description = "Template for a nix shell flake";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };
  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in {
      devShells."x86_64-linux".default = pkgs.mkShell {
        # these packages will be installed / made available
        packages = [ pkgs.zsh ];

        # this will pull in all dependencies of the specified packages as well
        inputsFrom = [ ];

        # this bash code runs upon entering the shell
        shellHook = ''echo -e "\nWelcome to your custom nix shell"'';

        # anything that's not recognize as a shell option will automatically
        # declare an environment variable for this shell
        # myEnvVar = "FOO";
        # another example:
        # LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [pkgs.ncurses]}";
      };
    };
}
