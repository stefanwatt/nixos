{ pkgs, ... }: {
  home.packages = with pkgs; [ vscode ];

  nixpkgs.config = { allowUnfree = true; };
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      vscodevim.vim
      svelte.svelte-vscode
      bradlc.vscode-tailwindcss
      esbenp.prettier-vscode
      formulahendry.auto-rename-tag
    ];
  };
}
