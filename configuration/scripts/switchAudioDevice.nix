{ pkgs, ... }:

let
  ponymix = "${pkgs.ponymix}/bin/ponymix";
  bash = "${pkgs.bash}/bin/bash";

  script = pkgs.writeShellScriptBin "switchAudioDevice" ''
    #!${bash}

    currentSinkId=$(${ponymix} defaults | sed -e '/^source/,+2d' -e '/^sink/{n;N;d}' | awk '{print $2}' | sed 's/://')

    headset="sink [0-9]+: alsa_output.usb-Logitech_PRO_X_Wireless_Gaming_Headset-00.analog-stereo"
    speaker="sink [0-9]+: bluez_output.08_EB_ED_CD_CB_02.1"
    interface="sink [0-9]+: alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo"

    deviceIds=($(${ponymix} -t sink list | sed -E -e "/$headset|$speaker|$interface/,+2!d" -e '/Avg/d' -e '/^\s/d' -e 's/sink ([0-9]+)/\1/' | awk -F'[: ]' '{print $1}'))

    for i in "${!deviceIds[@]}"; do
      if [[ "${deviceIds[$i]}" = "${currentSinkId}" ]]; then
        currentIndex="$i"
      fi
    done

    nextIndex=$(((currentIndex + 1) % ${#deviceIds[@]}))

    echo current index $currentIndex
    echo next index $nextIndex

    newSinkId=${deviceIds[$nextIndex]}
    newSinkId=${newSinkId%:}
    ${ponymix} set-default -d "$newSinkId"

    echo "Current sink ID: $currentSinkId"
    echo "New sink ID: $newSinkId"
  '';
in
{
  environment.systemPackages = [ script ];
}