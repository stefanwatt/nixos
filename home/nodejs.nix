{ pkgs, ... }: {
  home.packages = with pkgs; [
    bun
    nodejs_20
    nodePackages.typescript-language-server
    yarn
    nodePackages.typescript
  ];
}
