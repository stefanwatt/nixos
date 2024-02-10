{ pkgs, ... }: {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
  home.packages = with pkgs; [
    neovim-remote
    nixfmt
    neovide
    luajitPackages.luarocks-nix
    lua-language-server
    luajitPackages.jsregexp
    stylua
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim-nightly;
  };
}
