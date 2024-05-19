{ pkgs, inputs, ... }: {
  imports = [ inputs.ssbm.homeManagerModule ];
  nixpkgs.overlays = [ inputs.ssbm.overlay ];
  ssbm.slippi-launcher = {
    enable = true;
    isoPath = "/run/media/stefan/1TBHybrid/Games/smash-melee.iso";
    netplayDolphinPath = "/home/stefan/Games/dolphin";
    playbackDolphinPath = "/home/stefan/Games/dolphin";
    rootSlpPath = "/home/stefan/Games/dolphin";
    spectateSlpPath = "/home/stefan/Games/dolphin";
  };
  home.packages = [
    inputs.nix-bubblewrap.packages.${pkgs.system}.nix-bubblewrap # Add nix-bubblewrap to home.packages
  ];

}
