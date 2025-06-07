{ pkgs, ... }: {
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    extraComponents = [ "piper" "conversation" "wake_word" "stt" "tts" ];
    package = pkgs.home-assistant.override {
      extraPackages = py: with py; [ numpy onnxruntime ];
    };
    config = {
      homeassistant = {
        name = "Home";
        latitude = 50.7374;
        longitude = 7.0982;
        elevation = 60;
        unit_system = "metric";
        time_zone = "Europe/Berlin";
      };

      http = {
        server_host = "0.0.0.0";
        server_port = 8123;
      };
      tts = [{
        platform = "piper";
        voice = "en_US-lessac-medium";
      }];
    };
  };
  environment.systemPackages = with pkgs; [ piper-tts espeak-ng wyoming-piper ];
}
