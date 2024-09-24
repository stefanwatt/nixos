{ pkgs, nix-ld, pkgs-unstable, ... }: {

  imports = [ nix-ld.nixosModules.nix-ld ];
  users.users.stefan.shell = pkgs.zsh;
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
      go
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
      deno
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
    ] ++ (with pkgs-unstable; [
      zed-editor
      arduino-ide
      gh
      protobuf
      protoc-gen-grpc-web
      protoc-gen-js
      mods
      glow
      gum
      helix
    ]);
  programs.nix-ld.dev = {
    enable = true;
    libraries = with pkgs; [ nodejs_20 ];
  };
}
