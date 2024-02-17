{ ... }: {
  programs.git = {
    enable = true;
    userName = "Stefan Watt";
    userEmail = "stefan.watt@gmail.com";
    extraConfig = {
      core.editor = "vim";
      pull.rebase = true;
    };
  };
  programs.gh.enable = true;
}
