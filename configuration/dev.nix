{ pkgs, pkgs-unstable, ... }: {
  users.users.stefan.shell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs;
    [
      dotnet-sdk
      python311Full
      gcc9
      go
      delve
      gdlv
      vim
      neofetch
      git
      gh
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
      erlang
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
    ] ++ (with pkgs-unstable; [ wails gleam arduino-ide ]);
}
