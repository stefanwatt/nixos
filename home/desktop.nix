{ pkgs, pkgs-unstable, ... }: {
  home.packages = with pkgs;
    [
      btop
      discord
      remmina
      libreoffice
      xfce.thunar
      zsh
      ranger
      gparted
      blueman
      iftop
      unzip
      yt-dlp
      fd
      ripgrep
      fzf
      tty-clock
      p7zip
      rar
      dunst
      jq
      catppuccin-gtk
      ps
      appimage-run
      qdirstat
      wasistlos
    ] ++ (with pkgs-unstable; [ input-remapper brave ]);
}
