{ userSettings, ... }:
let
  wmConfig = userSettings.wm;
in {
  # Window manager selection logic
  selectedWM = if wmConfig.name or "hyprland" == "i3" then "i3" else "hyprland";
  
  # Import path for selected WM
  wmImportPath = if wmConfig.name or "hyprland" == "i3" then
    ../../home/i3/i3.nix
  else
    ../../home/hyprland/hyprland.nix;
    
  # System-level WM configuration
  wmSystemImports = if wmConfig.name or "hyprland" == "i3" then
    [ ../../configuration/xserver.nix ]
  else
    [ ];
    
  # Session command for display manager
  sessionCommand = if wmConfig.name or "hyprland" == "i3" then
    "i3"
  else
    "Hyprland";
}