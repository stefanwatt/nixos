{ config, pkgs, lib, ... }: 

let
    # Fetch the script
    updateScript = pkgs.writeShellScript "update-script" ''
        #!/${pkgs.bash}/bin/bash
        git=${pkgs.git}/bin/git 
        FULL_URL="https://github.com/stefanwatt/$2"
        # Check if the directory in $1 exists
        if [ ! -d "$1" ]; then
            # If not, clone the config from $2 into $1 and exit the program
            $git clone "$FULL_URL" "$1"
            exit 0
        fi

        cd "$1"

        # Check if $1 is a git repo
        if [ ! -d ".git" ]; then
            echo "Error: Directory is not a git repository"
            exit 1
        fi

        # Check that the remote origin is $FULL_URL
        REMOTE_URL="$($git config --get remote.origin.url | sed 's/\.git$//')" 
        if [ "$REMOTE_URL" != "$FULL_URL" ]; then
            echo "Error: Remote origin does not match $FULL_URL"
            echo "Remote origin is $REMOTE_URL"
            exit 1
        fi

        # Check if the worktree is clean (no uncommitted changes)
        if [ -n "$($git status --porcelain)" ]; then
            echo "You have uncommitted changes."
            echo "Do you want to (c)ommit, (s)tash or (e)xit?"
            read -r action

            case "$action" in
                c)
                    echo "Enter commit message:"
                    read -r commit_message
                    $git commit -am "$commit_message"
                    $git push origin master
                    ;;
                s)
                    $git stash
                    ;;
                e)
                    exit 0
                    ;;
                *)
                    echo "Invalid option"
                    exit 1
                    ;;
            esac
        else
            $git pull
            exit 0
        fi
        echo "Success"
    '';

    # List of repositories
    repos = [ "alacritty" "audacity" "autokey" "Code" "i3" "nvim" "rofi" ];

in
{
  # Run the script for each repository during system activation
  home.activation.updateDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ]
    (builtins.concatStringsSep "\n" (map (repo: ''
      echo "Updating ${repo}"
      ${updateScript} ${config.home.homeDirectory}/.config/${repo} ${repo}
    '') repos));

}