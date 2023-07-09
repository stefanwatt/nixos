{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      vscodevim.vim
      svelte.svelte-vscode
      bradlc.vscode-tailwindcss
      denoland.vscode-deno
      esbenp.prettier-vscode
      formulahendry.auto-rename-tag
    ];
  };
}
