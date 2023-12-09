{ config, pkgs, lib, ... }:
let
  myConfig = builtins.fetchGit {
    url = "https://github.com/stefanwatt/nvim";
    ref = "master";
  };
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "nixos-23.05";
  });
  sqliteLibPath = lib.makeLibraryPath [ pkgs.sqlite ];
in {
  imports = [ nixvim.homeManagerModules.nixvim ];

  home.activation.copyLuaConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Create the directory if it doesn't exist and set permissions
    mkdir -p ${config.xdg.configHome}/nvim/lua
    chmod 700 ${config.xdg.configHome}/nvim/lua

    # Ensure the directory is owned by the user
    chown stefan ${config.xdg.configHome}/nvim/lua

    # Copy the files, excluding 'init.lua'
    shopt -s extglob
    cp -r ${myConfig}/!(init.lua) ${config.xdg.configHome}/nvim/lua
  '';
  programs.nixvim = {
    extraPackages = [ pkgs.sqlite ];
    enable = true;
    extraConfigLua = ''
      vim.g.sqlite_clib_path = "${sqliteLibPath}" .. "/libsqlite3.so"

    '' + builtins.readFile "${myConfig}/init.lua";
    plugins = {
      lsp = {
        enable = true;
        servers = { nil_ls.enable = true; };
      };
    };
  };
}
