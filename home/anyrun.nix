{ inputs, pkgs, ... }: {
  nixpkgs.overlays = [
    (self: super: { anyrun = inputs.anyrun.packages.${pkgs.system}.anyrun; })
  ];

  programs.anyrun = {
    enable = true;
    config = {
      plugins = [ inputs.anyrun.packages.${pkgs.system}.applications ];
    };
  };
}
