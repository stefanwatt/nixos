{ userSettings, ... }:
let path = "/home/${userSettings.username}/Scripts/change-dir.sh";
in {
  home.file."${path}" = {
    text = ''
      directories=("~/Projects" "~/.config")
      find "''${directories[@]}" -type f 2>/dev/null | fzf
    '';
    force = true;
  };
}
