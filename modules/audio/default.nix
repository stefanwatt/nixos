{ pkgs, userSettings, ... }:
let
  lib = import ../../lib { inherit pkgs userSettings; };
  ponymix = "${pkgs.ponymix}/bin/ponymix";
  bash = "${pkgs.bash}/bin/bash";

  # Audio device definitions - make these configurable
  audioDevices = {
    headset = "sink [0-9]+: alsa_output.usb-Logitech_PRO_X_Wireless_Gaming_Headset-00.analog-stereo";
    speaker = "sink [0-9]+: bluez_output.08_EB_ED_CD_CB_02.1";
    interface = "sink [0-9]+: alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo";
  };

  # Cycle through audio devices script
  switchAudioDevice = pkgs.writeShellScriptBin "switch-audio-device" ''
    #!${bash}

    currentSinkId=$(${ponymix} defaults | sed -e '/^source/,+2d' -e '/^sink/{n;N;d}' | awk '{print $2}' | sed 's/://')

    headset="${audioDevices.headset}"
    speaker="${audioDevices.speaker}"
    interface="${audioDevices.interface}"

    deviceIds=($(${ponymix} -t sink list | sed -E -e "/$headset|$speaker|$interface/,+2!d" -e '/Avg/d' -e '/^\s/d' -e 's/sink ([0-9]+)/\1/' | awk -F'[: ]' '{print $1}'))

    for i in "''${!deviceIds[@]}"; do
      if [[ "''${deviceIds[$i]}" = "''${currentSinkId}" ]]; then
        currentIndex="$i"
      fi
    done

    nextIndex=$(((currentIndex + 1) % ''${#deviceIds[@]}))
    newSinkId=''${deviceIds[$nextIndex]}
    newSinkId=''${newSinkId%:}
    
    ${ponymix} set-default -d "$newSinkId"
    
    # Move all current inputs to new sink
    inputIds=$(${ponymix} list -t sink-input | sed '/^sink/!d' | awk '{print $2}' | sed 's/://')
    IFS=$'\n'
    set -f
    for i in $inputIds; do
      ${ponymix} -t sink-input -d "$i" move "$newSinkId"
    done

    echo "Switched to sink ID: $newSinkId"
  '';

in {
  # Home manager configuration only
  home.packages = [ switchAudioDevice ];
  
  # Home manager script symlink for backward compatibility
  home.file."Scripts/switch-audio-device.sh".source = "${switchAudioDevice}/bin/switch-audio-device";
}