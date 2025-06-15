{ pkgs, pkgs-unstable, ... }: {
  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };
  users.users.stefan.shell = pkgs-unstable.zsh;
  environment.shells = with pkgs; [ zsh ];
  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "100000";
  }];
  environment.systemPackages = with pkgs; [
    vim
    neofetch
    git
    lazygit
    cmake
    kitty
    pkg-config
    webkitgtk_4_1
    webkitgtk_6_0
    # not sure why/if i need these
    # rocmPackages.llvm.clang
    # clang-tools
    # bear
    # modd
    # ntfs3g
    # glib
    # inputs.lux.packages.${pkgs.system}.default
  ];
}
