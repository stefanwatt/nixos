{ pkgs, ... }:

let
  unstable = import (fetchTarball {
    sha256 = "sha256:1zfby2jsfkag275aibp81bx1g1cc305qbcy94gqw0g6zki70k1lx";
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  });
in {
  home.packages = with pkgs; [
    unstable.bun
    nodejs_20
    nodePackages.typescript-language-server
    yarn
    nodePackages.typescript
  ];
}
