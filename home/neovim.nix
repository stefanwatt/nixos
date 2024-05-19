{ pkgs, inputs, userSettings, ... }:
let
  luaConfigPaths = with userSettings;
    "/home/${username}/.config/nvim/lua/config/paths.lua";
in {
  nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];
  home.packages = with pkgs; [
    neovim-remote
    nixfmt
    neovide
    luajitPackages.luarocks-nix
    lua-language-server
    luajitPackages.jsregexp
    stylua
    imagemagick
    ueberzugpp
  ];
  home.file."${luaConfigPaths}" = {
    text = ''
      ---@class Config.Paths
      ---@field wm_config string
      local M = {
        wm_config = "${userSettings.wm.configFilePath}",
      }
      return M
    '';
    force = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim-nightly;
    extraLuaPackages = ps: [ ps.magick ];
  };
}
