{ system ? "x86_64-linux", username ? "stefan" }:
let
  theme = import ./theme.nix;
in {
  # System settings
  systemSettings = { 
    inherit system; 
  };

  # User settings
  userSettings = {
    inherit username;
    inherit (theme) colors font;
    
    # Window manager configuration
    wm = {
      name = "hyprland"; # or "i3"
      configFilePath = "~/.config/nixos/home/hyprland/hyprland.nix";
    };
  };
}