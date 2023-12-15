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
    if [ ! -d ${config.xdg.configHome}/nvim ]; then
      mkdir -p ${config.xdg.configHome}/nvim
    fi
    chmod 770 ${config.xdg.configHome}/nvim

    # Ensure the directory is owned by the user
    chown stefan ${config.xdg.configHome}/nvim

    # Copy the files, excluding 'init.lua'
    shopt -s extglob
    cp -r ${myConfig}/!(init.lua) ${config.xdg.configHome}/nvim
  '';
  programs.nixvim = {
    extraPackages = [ pkgs.sqlite ];
    enable = true;
    extraConfigLua = ''
      vim.g.sqlite_clib_path = "${sqliteLibPath}" .. "/libsqlite3.so"

    '' + builtins.readFile "${myConfig}/init.lua";
  };
}
