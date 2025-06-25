{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ docker ];
  boot.blacklistedKernelModules = [ "kvm-amd" ];
  virtualisation = {
    docker.enable = true;
    # oci-containers = {
    #   containers = {
    #     homeassistant = {
    #       image = "homeassistant/home-assistant:stable";
    #       autoStart = true;
    #       extraOptions = [ "--pull=newer" ];
    #       ports = [ "127.0.0.1:8123:8123" "127.0.0.1:8124:80" ];
    #       environment = { TZ = "Europe/Berlin"; };
    #     };
    #     wyoming-whisper = {
    #       image = "rhasspy/wyoming-whisper";
    #       autoStart = true;
    #       ports = [ "127.0.0.1:10300:10300" ];
    #       environment = { WHISPER_MODEL = "tiny-int8"; };
    #       cmd = [ "--model" "tiny-int8" "--uri" "tcp://0.0.0.0:10300" ];
    #     };
    #     wyoming-piper = {
    #       image = "rhasspy/wyoming-piper";
    #       autoStart = true;
    #       ports = [ "127.0.0.1:10200:10200" ];
    #       cmd =
    #         [ "--voice" "en_US-lessac-medium" "--uri" "tcp://0.0.0.0:10200" ];
    #     };
    #     wyoming-openwakeword = {
    #       image = "rhasspy/wyoming-openwakeword";
    #       autoStart = true;
    #       ports = [ "127.0.0.1:10100:10100" ];
    #       cmd = [ "--uri" "tcp://0.0.0.0:10100" ];
    #     };
    #   };
    # };
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
}
