{ lib, pkgs, ... }:
let
  sqliteLibPath = lib.makeLibraryPath [ pkgs.sqlite ];
  typescriptPath = lib.makeLibraryPath [ pkgs.nodePackages.typescript ];
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    # syntaxHighlighting.enable = true;
    shellAliases = {
      flash = "sudo dd bs=4M if=$1 of=$2 status=progress oflag=sync";
      mv = "rsync -avh --progress";
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
      mount-iso = "mount -o loop $1 $2";
      vbox = "VirtualBoxVM";
      nivm = "nvim";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker-compose" "docker" ];
      theme = "dst";
    };
    initExtra = ''
      bindkey '^f' autosuggest-accept
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      export PATH=$PATH:/home/stefan/Scripts:/home/stefan/Applications
      export PYTHONPATH="${pkgs.python311Packages.packaging}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.six}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.dateutil}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.ruamel-yaml}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.ruamel-base}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.pykwalify}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.colorama}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.pyyaml}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.west}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.pyelftools}/${pkgs.python311.sitePackages}:$PYTHONPATH"
      export SQLITE3_LIB=${sqliteLibPath}/libsqlite3.so
      export GRIMBLAST_EDITOR=${pkgs.swappy}
      export TSSERVER=${typescriptPath}/lib/node_modules/typescript/lib/tsserver.js
      export NODE=${pkgs.nodejs_20}/bin/node
      source ~/.config/.extra-zshrc.zsh
      find_project() {
          local selected_directory=$(find ~/Projects -maxdepth 1 -type d -printf "%f\n" | fzf --height 40% --border)
          if [[ -n $selected_directory ]]; then
              nvim ~/Projects/"$selected_directory"
          else
              echo "No directory selected."
          fi
      }
      if [[ "$TERM" =~ screen ]] && [[ -n "$TMUX" ]]; then
          export TERM='tmux-256color'
      fi
    '';
  };
}
