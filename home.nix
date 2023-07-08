{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.username = "stefan";
  home.homeDirectory = "/home/stefan";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    btop
    rustup
    (pkgs.nerdfonts.override { fonts = [ "VictorMono" "DroidSansMono" ]; })
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ll = "ls -l";
      nu =
        "sudo nixos-rebuild switch -I nixos-config=/home/stefan/.config/nixos/configuration.nix";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker-compose" "docker" ];
      theme = "dst";
    };
    initExtra = ''
      bindkey '^f' autosuggest-accept
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "Default";
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
          bitwarden
        ];
      };
    };
  };
  programs.git = {
    enable = true;
    userName = "Stefan Watt";
    userEmail = "stefan.watt@gmail.com";
  };
  programs.gh.enable = true;
}

