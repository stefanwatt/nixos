{ pkgs, ... }: {
  gtk = {
    enable = true;
    font = {
      name = "Victor Mono Nerd Font Mono";
      size = 12;
    };
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
