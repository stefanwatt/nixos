{ pkgs, userSettings, ... }: {
  gtk = {
    enable = true;
    font = userSettings.font.regular;
    theme = {
      name = "Catppuccin-Frappe-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "frappe";
      };
    };
  };
}
