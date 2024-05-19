{ lib, userSettings, pkgs, ... }:
let
  sqliteLibPath = lib.makeLibraryPath [ pkgs.sqlite ];
  typescriptPath = lib.makeLibraryPath [ pkgs.nodePackages.typescript ];
in {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      arudino-ide = "LIBGL_ALWAYS_SOFTWARE=1 arduino-ide";
      wd = "wails dev --loglevel Error";
      flash = "sudo dd bs=4M if=$1 of=$2 status=progress oflag=sync";
      copy = "rsync -avh --progress";
      ytdl = "yt-dlp -o ~/Music/$1 -x --audio-format mp3 $2";
      ll = "ls -l";
      turso = "~/.turso/turso";
      nu = "sudo nixos-rebuild switch --flake ~/.config/nixos";
      n = "nvim";
      nvi2 = "nvim";
      hu =
        "home-manager switch --flake ~/.config/nixos/#${userSettings.username}";
      nfu = "sudo nix flake update ~/.config/nixos";
      rollback =
        "sudo nix-env -p /nix/var/nix/profiles/system --rollback && sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch";
      split = "bash ~/Scripts/split-screen.sh";
      unsplit = "bash ~/Scripts/unsplit-screen.sh";
      switchAudio = "bash ~/Scripts/switchAudioDevice.sh";
      ranger = ''
        ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'';
      mount-iso = "mount -o loop $1 $2";
      vbox = "VirtualBoxVM";
    };
    oh-my-zsh = {
      enable = true;
      theme = "dst";
    };
    initExtra = ''
      bindkey '^f' autosuggest-accept
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      export PATH=$PATH:/home/stefan/Scripts:/home/stefan/Applications:/home/stefan/.local/share/nvim/mason/bin
      export ARDUINO_LANGUAGE_SERVER_CONFIG=~/.config/arduino-cli/arduino-cli.yaml
      export PYTHONPATH="${pkgs.python311Packages.packaging}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.six}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.dateutil}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.ruamel-yaml}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.ruamel-base}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.pykwalify}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.colorama}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.pyyaml}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.west}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.pyelftools}/${pkgs.python311.sitePackages}:$PYTHONPATH"
      export SQLITE3_LIB=${sqliteLibPath}/libsqlite3.so
      export GRIMBLAST_EDITOR=${pkgs.swappy}
      export TSSERVER=${typescriptPath}/lib/node_modules/typescript/lib/tsserver.js
      export NODE=${pkgs.nodejs_20}/bin/node
      autoload -Uz compinit
      zstyle ':completion:*' use-compinit no
      [[ $commands[compinit] ]] && compinit
      autoload -Uz add-zsh-hook
      fzf_cd_neovim_tabbed() {
          local dir=$(find ~/Projects ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)
          if [[ -n $dir ]]; then
              cd "$dir" && nvim .
          fi
          zsh
      }
      if [[ "$TERM" =~ screen ]] && [[ -n "$TMUX" ]]; then
          export TERM='tmux-256color'
      fi
      function ff() {
        local repo_root=$(git rev-parse --show-toplevel 2> /dev/null)
        if [[ $? != 0 ]]; then
          find $1 -mindepth 1 | fzf
          return 0
        fi

        git ls-files | fzf --preview 'cat {}'
      }
      function fw() {
        rg --line-number --no-heading --color=always --smart-case "" $1 | fzf -d ':' -n 2.. --ansi --no-sort --preview-window 'down:20%:+{2}' --preview 'bat --style=numbers --color=always --highlight-line {2} {1}'
      }
    '';
  };
}
