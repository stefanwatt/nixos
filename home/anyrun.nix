{ inputs, pkgs, ... }: {
  imports = [ inputs.anyrun.homeManagerModules.default ];
  nixpkgs.overlays = [
    (self: super: { anyrun = inputs.anyrun.packages.${pkgs.system}.anyrun; })
  ];

  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        inputs.anyrun.packages.${pkgs.system}.rink
        inputs.anyrun.packages.${pkgs.system}.translate
        inputs.anyrun.packages.${pkgs.system}.applications
      ];
      width = { fraction = 0.3; };
      ignoreExclusiveZones = false;
      layer = "top";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;
    };
  };
}

