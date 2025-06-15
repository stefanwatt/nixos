{ pkgs, pkgs-unstable, inputs, userSettings, ... }:
let
  lib = import ../../lib { inherit pkgs userSettings; };
  luaConfigPaths = "${lib.userHome}/.config/nvim/lua/config/paths.lua";
  flakeTemplate = ../../home/templates/flake/flake.nix;
in {
  # Development file templates and scripts
  home.file.".config/nix-templates/flake.nix".source = flakeTemplate;
  
  home.file."Scripts/nix-shell-init" = {
    text = ''
      #!/run/current-system/sw/bin/bash

      if [ -f "flake.nix" ]; then
          echo "Error: flake.nix already exists"
          exit 1
      fi

      cp ${flakeTemplate} ./flake.nix
      echo "use flake" > .envrc
      direnv allow

      echo "Nix shell initialized!"
    '';
    executable = true;
  };

  # Neovim configuration paths
  home.file."${luaConfigPaths}" = {
    text = ''
      ---@class Config.Paths
      ---@field wm_config string
      local M = {
        wm_config = "${userSettings.wm.hyprland.configFilePath or userSettings.wm.i3.configFilePath}",
      }
      return M
    '';
    force = true;
  };

  # Neovim configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraLuaPackages = ps: [ ps.magick ];
  };

  # Development packages
  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.victor-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    
    # Languages and runtimes
    rustup
    bun
    nodejs_20
    yarn
    lua
    erlang_27
    elixir
    gcc
    zig
    
    # Language servers and tools
    nodePackages.typescript-language-server
    nodePackages.typescript
    lua-language-server
    marksman
    
    # Development tools
    air
    postman
    delve
    gdlv
    postgresql
    gnumake
    maven
    bat
    highlight
    sad
    delta
    gotestfmt
    wails
    deno
    tailwindcss
    gh
    neovim-remote
    nixfmt-classic
    neovide
    luajitPackages.luarocks-nix
    luajitPackages.jsregexp
    stylua
    imagemagick
    ueberzugpp
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