{ config, pkgs, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" "gcadapter_oc" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.gcadapter-oc-kmod ];
}
