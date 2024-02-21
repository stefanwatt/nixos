{ pkgs, ... }:

let
  xrandr = "${pkgs.xorg.xrandr}/bin/xrandr";
  script = pkgs.writeShellScriptBin 
in {
  environment.systemPackages = [ script ];
  script = script;
}
