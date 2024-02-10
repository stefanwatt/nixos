{ pkgs, ... }:

let
  unstable = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { };
in {
  home.packages = with pkgs; [
    unstable.bun
    nodejs_20
    nodePackages.typescript-language-server
    yarn
    nodePackages.typescript
  ];
}
