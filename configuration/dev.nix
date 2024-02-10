{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    dotnet-sdk
    python311Full
    gcc9
    go
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
  ];
}
