{ pkgs, userSettings, inputs, ... }: {
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix.autoEnable = true;
  stylix.targets.gtk.enable = true;
  stylix.homeManagerIntegration.followSystem = true;
  stylix.base16Scheme = {
    base00 = "#303446";
    base01 = "#292c3c";
    base02 = "#414559";
    base03 = "#51576d";
    base04 = "#626880";
    base05 = "#c6d0f5";
    base06 = "#f2d5cf";
    base07 = "#babbf1";
    base08 = "#e78284";
    base09 = "#ef9f76";
    base0A = "#e5c890";
    base0B = "#a6d189";
    base0C = "#81c8be";
    base0D = "#8caaee";
    base0E = "#ca9ee6";
    base0F = "#eebebe";
  };
  stylix.image = "/home/${userSettings.username}/.config/myi3/wallpaper.png";
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 5;
  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override {
        fonts = [ "VictorMono" "DroidSansMono" "FiraCode" ];
      };
      name = "Victor Mono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };
  stylix.polarity = "dark";
}
