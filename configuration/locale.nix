{ pkgs, ... }: {
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [ fcitx5-anthy fcitx5-gtk fcitx5-mozc ];
  };
  environment.systemPackages = with pkgs; [
    fcitx5-anthy
    fcitx5-gtk
    fcitx5-mozc
    source-han-sans
    noto-fonts-cjk-sans
  ];
  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [ source-han-sans noto-fonts-cjk-sans ];
    fontconfig = {
      defaultFonts = { sansSerif = [ "DejaVu Sans" "Noto Sans JP" ]; };
    };
  };
}
