{ pkgs, pkgs-unstable, inputs, userSettings, ... }:
let
  luaConfigPaths = with userSettings;
    "/home/${username}/.config/nvim/lua/config/paths.lua";
in {
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
  home.packages = with pkgs;
    [
      nerd-fonts.victor-mono
      nerd-fonts.droid-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      rustup
      bun
      nodejs_20
      nodePackages.typescript-language-server
      yarn
      nodePackages.typescript
      air
      postman
      delve
      gdlv
      postgresql
      gnumake
      maven
      marksman
      erlang_27
      elixir
      bat
      highlight
      sad
      delta
      lua
      gotestfmt
      wails
      deno
      tailwindcss
      gh
      lua
      neovim-remote
      nixfmt-classic
      neovide
      luajitPackages.luarocks-nix
      lua-language-server
      luajitPackages.jsregexp
      stylua
      imagemagick
      ueberzugpp
      stylua
      gcc
      zig
    ] ++ (with pkgs-unstable; [
      go
      mods
      python311Packages.python-dotenv
      python311Packages.requests
      python311Packages.pynvim
      python311Packages.prompt-toolkit
      python311Packages.tiktoken
    ]);
}
