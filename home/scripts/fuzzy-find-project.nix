{ userSettings, ... }:
let path = "/home/${userSettings.username}/Scripts/change-dir.sh";
in {
  home.file."${path}" = {
    text = ''
      #!/run/current-system/sw/bin/bash
      directories=("~/Projects" "~/.config")
      find "''${directories[@]}" -type f 2>/dev/null | fzf
    '';
    force = true;
  };
}
