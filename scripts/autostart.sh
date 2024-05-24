#!/bin/sh

once() {
  if ! pgrep -f $1 >/dev/null; then
    $@ &
  fi
}

once xsettingsd
once picom --daemon
once flameshot
once copyq
once nm-applet
once lxpolkit
once gnome-keyring-daemon -fr
once darkman run

setxkbmap us,tr -option grp:alt_caps_toggle
xsetroot -cursor_name left_ptr
xset -b # disable beep sound
