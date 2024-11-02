{ lib, userSettings, pkgs, pkgs-unstable, ... }:
let
  sqliteLibPath = lib.makeLibraryPath [ pkgs.sqlite ];
  typescriptPath = lib.makeLibraryPath [ pkgs.nodePackages.typescript ];
in {
  programs = {
    nushell = {
      package = pkgs-unstable.nushell;
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      # configFile.source = ./.../config.nu;
      # for editing directly to config.nu 
      environmentVariables = {
        # PATH=$PATH:/home/stefan/Scripts:/home/stefan/Applications:/home/stefan/.local/share/nvim/mason/bin
        ARDUINO_LANGUAGE_SERVER_CONFIG =
          "'~/.config/arduino-cli/arduino-cli.yaml'";
        PYTHONPATH =
          "'${pkgs.python311Packages.packaging}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.six}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.dateutil}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.ruamel-yaml}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.ruamel-base}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.pykwalify}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.colorama}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.pyyaml}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.west}/${pkgs.python311.sitePackages}:${pkgs.python311Packages.pyelftools}/${pkgs.python311.sitePackages}:$PYTHONPATH'";
        SQLITE3_LIB = "'${sqliteLibPath}/libsqlite3.so'";
        TSSERVER =
          "'${typescriptPath}/lib/node_modules/typescript/lib/tsserver.js'";
        NODE = "'${pkgs.nodejs_20}/bin/node'";
      };
      extraConfig = ''
        if ("/home/stefan/.config/nushell/secrets.nu" | path exists) {
          source /home/stefan/.config/nushell/secrets.nu
        }
        let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
        }
        $env.config = {
         cursor_shape: {
           vi_insert: line
           vi_normal: block
         }
         edit_mode: vi
         show_banner: false,
         completions: {
         case_sensitive: false # case-sensitive completions
         quick: true    # set to false to prevent auto-selecting completions
         partial: true    # set to false to prevent partial filling of the prompt
         algorithm: "fuzzy"    # prefix or fuzzy
         external: {
         # set to false to prevent nushell looking into $env.PATH to find more suggestions
             enable: true 
         # set to lower can improve completion performance at the cost of omitting some options
             max_results: 100 
             completer: $carapace_completer # check 'carapace_completer' 
           }
         }
        } 
        $env.PATH = ($env.PATH | 
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
        )

        def flash [source: string, target: string] {
            sudo dd bs=4M if=$source of=$target status=progress oflag=sync
        }

        def ytdl [filename: string, url: string] {
            yt-dlp -o ~/Music/$filename -x --audio-format mp3 $url
        }

        def nixu [] {
          sudo nixos-rebuild switch --flake ~/.config/nixos 
        }

        def mount-iso [a:string, b:string] {
          mount -o loop $a $b
        }

        def hu [] {
          home-manager switch --flake ~/.config/nixos/#${userSettings.username}
        }

        def rollback [] {
          sudo nix-env -p /nix/var/nix/profiles/system --rollback;sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
        }
      '';
      shellAliases = {
        arudino-ide = "LIBGL_ALWAYS_SOFTWARE=1 arduino-ide";
        wd = "wails dev --loglevel Error";
        copy = "rsync -avh --progress";
        ll = "ls -l";
        turso = "~/.turso/turso";
        nixu = "sudo nixos-rebuild switch --flake ~/.config/nixos";
        n = "nvim";
        nvi2 = "nvim";
        nfu = "`sudo nix flake update ~/.config/nixos`";
        split = "bash ~/Scripts/split-screen.sh";
        unsplit = "bash ~/Scripts/unsplit-screen.sh";
        switchAudio = "bash ~/Scripts/switchAudioDevice.sh";
        py = "python3.11";
        vbox = "VirtualBoxVM";
        modscl = "mods --continue-last";
        modsclip = "xclip -selection clipboard -o | mods";
        epni = "ep --noninteractive";
      };
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        format = "$all";
        add_newline = true;
        directory = {
          truncation_length = 9;
          truncate_to_repo = false;
        };
        git_status = {
          # format = "[ $branch]($style)[$status]($style) ";
          ahead = " ⇡ "; # Ahead of the remote
          behind = "  "; # Behind the remote
          diverged = " ⇕ "; # Diverged from the remote
          untracked = ""; # Untracked files
          stashed = ""; # Stashed changes
          modified = "  "; # Modified but unstaged
          staged = ""; # Staged changes
          renamed = ""; # Renamed files
          deleted = " 󰆴 ";
        };
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };
}
