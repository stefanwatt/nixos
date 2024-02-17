{ pkgs, ... }: {
  users.users.stefan = {
    isNormalUser = true;
    description = "stefan";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
    packages = with pkgs; [ firefox ];
  };
  users.extraGroups = {
    vboxusers.members = [ "stefan" ];
    docker.members = [ "stefan" ];
  };
}
