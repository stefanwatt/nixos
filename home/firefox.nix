{ config, pkgs, ... }: {

  programs.firefox = {
    enable = true;
    # preferences = { "full-screen-api.ignore-widgets" = true; };
    profiles = {
      default = {
        id = 0;
        name = "Default";
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
          bitwarden
        ];
      };
    };
  };
}
