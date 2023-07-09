{ config, pkgs, ... }: {
  users.users.stefan = {
    isNormalUser = true;
    description = "stefan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ firefox ];
  };
}
