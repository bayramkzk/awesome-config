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
once /usr/lib/polkit-kde-authentication-agent-1
once gnome-keyring-daemon -fr

setxkbmap us,tr -option grp:alt_caps_toggle
xsetroot -cursor_name left_ptr
xset -b # disable beep sound
