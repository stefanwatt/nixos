{ userSettings, ... }: {
  users.users."${userSettings.username}" = {
    isNormalUser = true;
    description = userSettings.username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "vboxusers"
      "dialout"
      "uucp"
      "audio"
      "video"
      "render"
    ];
  };
  users.extraGroups = {
    vboxusers.members = [ userSettings.username ];
    docker.members = [ userSettings.username ];
  };
}
