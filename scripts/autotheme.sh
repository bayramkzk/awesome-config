#!/bin/bash

case "$1" in
	-l|--light) THEME="light";;
	-d|--dark) THEME="dark";;
	*) echo "Usage: $0 [-l|--light|-d|--dark]"; exit 0;;
esac

FONT_NAME="Fira Sans Regular 11"
MONOSPACE_FONT_NAME="Iosevka Nerd Font Mono Medium 11"
CURSOR_THEME="elementary"

if [[ $THEME = "light" ]]; then
	GTK_THEME="adw-gtk3"
	ICON_THEME="Papirus-Light"
	DAY_NIGHT="day"
else
	GTK_THEME="adw-gtk3-dark"
	ICON_THEME="Papirus-Dark"
	DAY_NIGHT="night"
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

ln -sf "$HOME/.config/alacritty/tokyonight/tokyonight_$DAY_NIGHT.toml" \
	"$HOME/.config/alacritty/tokyonight/tokyonight.toml"
touch $HOME/.config/alacritty/alacritty.toml

tmux source-file ~/.config/tmux/tmux.conf
