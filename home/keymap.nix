{ userSettings, ... }:
let path = with userSettings; "/home/${username}/.config/hypr/pyprland.toml";
in {
  home.file."${path}" = {
    text = ''
      default partial alphanumeric_keys
      xkb_symbols "basic" {
        name[Group1] = "English (US, international with German umlaut)";
        key <FK15> { [ u, U, udiaeresis, Udiaeresis ] };
        key <FK14> { [ o, O, odiaeresis, Odiaeresis ] };
        key <FK13> { [ a, A, adiaeresis, Adiaeresis ] };
        key <FK16> { [ s, S, ssharp ] };
      };
    '';
    force = true;
  };
}
