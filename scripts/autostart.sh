#!/bin/sh

once() {
  if ! pgrep -f $1 >/dev/null; then
    $@ &
  fi
}

once xsettingsd
once picom --daemon
once flameshot
once parcellite
once nextcloud --background

setxkbmap us,tr -option grp:alt_caps_toggle
xsetroot -cursor_name left_ptr
xset -b # disable beep sound
