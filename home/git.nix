{ ... }: {
  programs.git = {
    enable = true;
    userName = "Stefan Watt";
    userEmail = "stefan.watt@gmail.com";
    extraConfig = {
      core.editor = "vim";
      pull.rebase = true;
      mergetool.cmd =
        "nvim -d $LOCAL $BASE $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
    };
  };
  programs.gh.enable = true;
}
