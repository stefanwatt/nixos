{ pkgs, ... }:

let
  ponymix = "${pkgs.ponymix}/bin/ponymix";
  rofi = "${pkgs.rofi}/bin/rofi";
  bash = "${pkgs.bash}/bin/bash";
  awk = "${pkgs.gawk}/bin/awk";
  grep = "${pkgs.gnugrep}/bin/grep";
  echo = "${pkgs.coreutils}/bin/echo";

  script = pkgs.writeShellScriptBin "audio-output-picker" ''
    #!${bash}

    sink=$(${ponymix} -t sink list|${awk} '/^sink/ {s=$1" "$2;getline;gsub(/^ +/,"",$0);print s" "$0}'|${rofi} -dmenu -p 'pulseaudio sink:' -location 0 -width 100|${grep} -Po '[0-9]+(?=:)') &&

    ${ponymix} set-default -d $sink &&
    for input in $(${ponymix} list -t sink-input|${grep} -Po '[0-9]+(?=:)');do
      ${echo} "$input -> $sink"
      ${ponymix} -t sink-input -d $input move $sink
    done
  '';
in
{
  environment.systemPackages = [ script ];
}