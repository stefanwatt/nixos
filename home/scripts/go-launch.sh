#!/run/current-system/sw/bin/bash
export XDG_DATA_DIRS=/nix/store/1rr497fk0jmibaj65983i7nipz2knmc8-gsettings-desktop-schemas-46.0/share/gsettings-schemas/gsettings-desktop-schemas-46.0:/nix/store/hdn2gb5xa3amcpn4g90hscplwbnk56bz-gtk+3-3.24.43/share/gsettings-schemas/gtk+3-3.24.43:$XDG_DATA_DIRS
export GIO_MODULE_DIR=/nix/store/64kgf2hd3z008pnmrcs1c454dqfciqwh-glib-networking-2.80.0/lib/gio/modules/
exec ~/Projects/go-launch/build/bin/go-launch
