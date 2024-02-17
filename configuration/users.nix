{ ... }: {
  users.users.stefan = {
    isNormalUser = true;
    description = "stefan";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
  };
  users.extraGroups = {
    vboxusers.members = [ "stefan" ];
    docker.members = [ "stefan" ];
  };
}
