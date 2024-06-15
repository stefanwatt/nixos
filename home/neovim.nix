{ pkgs, pkgs-unstable, inputs, userSettings, ... }:
let
  luaConfigPaths = with userSettings;
    "/home/${username}/.config/nvim/lua/config/paths.lua";
in {
  home.packages = with pkgs;
    [
      neovim-remote
      nixfmt
      neovide
      luajitPackages.luarocks-nix
      lua-language-server
      luajitPackages.jsregexp
      stylua
      imagemagick
      ueberzugpp
    ] ++ (with pkgs-unstable; [
      python311Packages.python-dotenv
      python311Packages.requests
      python311Packages.pynvim
      python311Packages.prompt-toolkit
      python311Packages.tiktoken
    ]);
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
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraLuaPackages = ps: [ ps.magick ];
  };
}
