{ pkgs, pkgs-unstable, inputs, ... }: {

  # imports = [ nix-ld.nixosModules.nix-ld ];
  users.users.stefan.shell = pkgs-unstable.zsh;
  environment.shells = with pkgs; [ zsh ];
  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "100000";
  }];
  environment.systemPackages = with pkgs;
    [
      dotnet-sdk
      (python311Full.withPackages (ps: with ps; [ tiktoken ]))
      gcc9
      postman

      delve
      gdlv
      vim
      neofetch
      git
      lazygit
      ninja
      cmake
      air
      postgresql
      gnumake
      niv
      fnm
      temurin-bin
      maven
      marksman
      kitty
      erlang_27
      elixir
      libatomic_ops
      bat
      rebar3
      vial
      via
      qmk
      ncurses
      highlight
      sad
      diff-so-fancy
      delta
      lua
      gotestfmt
      arduino-language-server
      arduino-cli
      rocmPackages.llvm.clang
      arduino-core
      clang-tools
      bear
      modd
      yarn
      wails
      pkg-config
      webkitgtk
      ntfs3g
      glib
      inputs.lux.packages.${pkgs.system}.default
    ] ++ (with pkgs-unstable; [
      claude-code
      gh
      protobuf
      protoc-gen-grpc-web
      protoc-gen-js
      mods
      glow
      gum
      helix
      deno
      ghex
      supabase-cli
      tailwindcss
      electron
      love
      # windsurf
      code-cursor
      typora
      multipass
      go
    ]);
  # programs.nix-ld.dev = {
  #   enable = true;
  #   libraries = with pkgs; [ nodejs_20 ];
  # };
}
