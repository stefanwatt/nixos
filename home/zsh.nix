{ lib, pkgs, ... }:
let sqliteLibPath = lib.makeLibraryPath [ pkgs.sqlite ];
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ytdl = "yt-dlp -o ~/Music/$1 -x --audio-format mp3 $2";
      ll = "ls -l";
      turso = "~/.turso/turso";
      nu =
        "sudo nixos-rebuild switch -I nixos-config=/home/stefan/.config/nixos/configuration.nix";
      split = "bash ~/Scripts/split-screen.sh";
      unsplit = "bash ~/Scripts/unsplit-screen.sh";
      switchAudio = "bash ~/Scripts/switchAudioDevice.sh";
      ranger = ''
        ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'';
      nvim = "nvim --listen ~/.local/share/nvim/nvimsocket";
      mount-iso = "mount -o loop $1 $2";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker-compose" "docker" ];
      theme = "dst";
    };
    initExtra = ''
      bindkey '^f' autosuggest-accept
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      export PATH=$PATH:/home/stefan/Scripts
      export SQLITE3_LIB=${sqliteLibPath}/libsqlite3.so
    '';
  };
}
