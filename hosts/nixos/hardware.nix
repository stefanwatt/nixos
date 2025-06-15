{ config, pkgs, ... }:
{
  # Hardware-specific configuration
  imports = [ ./hardware-configuration.nix ];

  # Boot configuration
  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" "gcadapter_oc" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    extraModulePackages = [ config.boot.kernelPackages.gcadapter-oc-kmod ];
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
      magicOrExtension = "\\x7fELF....AI\\x02";
    };
  };

  # Hardware configuration
  hardware = {
    firmware = [ pkgs.linux-firmware ];
    graphics = {
      package = pkgs.mesa;
      enable = true;
      extraPackages = [ pkgs.amdvlk ];
    };
    bluetooth.enable = true;
  };
}