{ pkgs, inputs, ... }: {
  nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];
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
