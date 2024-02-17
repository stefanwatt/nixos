{ pkgs, inputs, ... }: {
  nixpkgs.overlays = [ inputs.templ.overlay ];
  home.packages = with pkgs; [ templ ];
}

