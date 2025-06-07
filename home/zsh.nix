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
    autosuggestion.enable = true;
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      gvim = "/home/stefan/Projects/nvim-gui/build/bin/nvim-gui";
      arudino-ide = "LIBGL_ALWAYS_SOFTWARE=1 arduino-ide";
      wd = "wails dev --loglevel Error";
      flash = "sudo dd bs=4M if=$1 of=$2 status=progress oflag=sync";
      fm =
        "nvim -c 'lua require(\"mini.files\").open(vim.fn.argc() > 0 and vim.fn.argv()[1] or nil, false)' -c 'lua vim.defer_fn(function() vim.opt.laststatus=0 end,100)'  -c 'autocmd User MiniFilesExplorerClose quitall!'";
      copy = "rsync -avh --progress";
      ytdl = "yt-dlp -o ~/Music/$1 -x --audio-format mp3 $2";
      neodiff = "NVIM_APPNAME=nvim-minimal nvim -d -o $1 $2";
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
      py = "python3.11";
      ranger = ''
        ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'';
      mount-iso = "mount -o loop $1 $2";
      vbox = "VirtualBoxVM";
      W =
        "nvim -c 'setlocal buftype=nofile bufhidden=wipe' -c 'nnoremap <buffer> q :q!<CR>' -";
      epni = "ep --noninteractive";
      fzfind = ''fzf --preview="bat --color=always {}"'';
      find-file = "find $1 -type f -name $2";
      find-dir = "find $1 -type d -name $2";
      modscl = "mods --continue-last";
      modsclip = "xclip -selection clipboard -o | mods";
    };
    oh-my-zsh = {
      enable = true;
      theme = "dst";
    };
    initExtra = ''
      bindkey '^f' autosuggest-accept
      source ~/.extra-zshrc
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      export PATH=$PATH:/home/stefan/Scripts:/home/stefan/Applications:/home/stefan/.local/share/nvim/mason/bin
      export ARDUINO_LANGUAGE_SERVER_CONFIG=~/.config/arduino-cli/arduino-cli.yaml
      export MANPAGER='nvim +Man!'
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

      function wezterm_split_horizontal() {
        wezterm cli split-pane --horizontal
      }

      function wezterm_split_bottom() {
        wezterm cli split-pane --bottom
      }

      function wezterm_close_pane() {
        wezterm cli kill-pane
      }

      function enter_copy_mode_visual() {
        # Simulate 'Ctrl+Shift+X'
        zle -C ctrl_shift_x "send-keys C-x"
        zle -C ctrl_shift_x "send-keys C-S-x"
        zle ctrl_shift_x

        # Delay to ensure the command is processed
        sleep 0.1
        
        # Simulate 'v'
        zle -C v_key "send-keys v"
        zle v_key
      }

      function enter_copy_mode_visual_line() {
        # Simulate 'Ctrl+Shift+X'
        zle -C ctrl_shift_x "send-keys C-x"
        zle -C ctrl_shift_x "send-keys C-S-x"
        zle ctrl_shift_x

        # Delay to ensure the command is processed
        sleep 0.1
        
        # Simulate 'V'
        zle -C v_key "send-keys V"
        zle v_key
      }

      function zvm_after_lazy_keybindings() {
        zvm_define_widget wezterm_split_horizontal
        zvm_define_widget wezterm_split_bottom
        zvm_define_widget wezterm_close_pane
        zvm_define_widget enter_copy_mode_visual
        zvm_define_widget enter_copy_mode_visual_line

        zvm_bindkey vicmd 'v' enter_copy_mode_visual
        zvm_bindkey vicmd 'V' enter_copy_mode_visual_line

        zvm_bindkey vicmd ' v' wezterm_split_horizontal
        zvm_bindkey vicmd ' h' wezterm_split_bottom
        zvm_bindkey vicmd ' q' wezterm_close_pane
      }
    '';
  };
}
