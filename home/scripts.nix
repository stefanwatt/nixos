{ lib, ... }: {
  imports = [
    (lib.file.mkOutOfStoreSymlink
      (__dirname + "/scripts/switch-audio-device.nix"))
  ];
}
