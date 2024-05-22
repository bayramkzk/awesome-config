#!/bin/bash

case "$1" in
	-h|--help) echo "Usage: $0 [-l|--light|-d|--dark]"; exit 0;;
	-l|--light) THEME="light";;
	-d|--dark) THEME="dark";;
	*)
		since_midnight=$(($(date +%s) - $(date -d '00:00:00' +%s)))
		sunrise=$((6*60*60))
		sunset=$((20*60*60))
		[ "$since_midnight" -ge "$sunrise" ] && [ "$since_midnight" -lt "$sunset" ] \
			&& THEME="light" || THEME="dark";;
esac

FONT_NAME="Fira Sans Regular 11"
MONOSPACE_FONT_NAME="ZedMono Nerd Font Mono Medium 11"
CURSOR_THEME="elementary"

if [[ $THEME = "light" ]]; then
	GTK_THEME="adw-gtk3"
	ICON_THEME="Papirus-Light"
else
	GTK_THEME="adw-gtk3-dark"
	ICON_THEME="Papirus-Dark"
fi

gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME"

gsettings set org.gnome.desktop.interface document-font-name "$FONT_NAME"
gsettings set org.gnome.desktop.interface font-name "$FONT_NAME"
gsettings set org.gnome.desktop.interface monospace-font-name "$MONOSPACE_FONT_NAME"

sed -i -e 's/Net\/ThemeName.*/Net\/ThemeName "'"$GTK_THEME"'"/g' \
	-e 's/Net\/IconThemeName.*/Net\/IconThemeName "'"$ICON_THEME"'"/g' \
	-e 's/Gtk\/CursorThemeName.*/Gtk\/CursorThemeName "'"$CURSOR_THEME"'"/g' \
	~/.config/xsettingsd/xsettingsd.conf
killall -HUP xsettingsd

