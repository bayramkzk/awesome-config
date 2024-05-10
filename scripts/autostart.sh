#!/bin/sh

once() {
  if ! pgrep -f $1 >/dev/null; then
    $@ &
  fi
}

once xsettingsd
once picom
