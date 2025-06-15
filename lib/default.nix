{ pkgs, userSettings, ... }:
{
  # Common systemd graphical service template
  graphicalService = execStart: {
    Unit = {
      Description = execStart;
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = {
      Type = "simple";
      ExecStart = execStart;
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
      Environment = [
        "DISPLAY=:0"
        "PATH=${pkgs.ps}/bin:/run/current-system/sw/bin:/home/${userSettings.username}/.nix-profile/bin/"
      ];
    };
  };

  # Helper for user home path
  userHome = "/home/${userSettings.username}";
  
  # Helper for config path
  configPath = "/home/${userSettings.username}/.config/nixos";
}