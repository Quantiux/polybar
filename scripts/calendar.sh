#!/usr/bin/env bash

# display calendar with today's date highlighted

# get screen dimensions
SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f1)
SCREEN_HEIGHT=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f2)

# polybar settings
POLYBAR_HEIGHT=16  # polybar height in pixels
X_OFFSET=10  # offset from polybar's right edge
Y_OFFSET=2  # offset from polybar's bottom

# calculate popup position
YAD_WIDTH=222  # adjust as needed
YAD_HEIGHT=150 # adjust as needed
pos_x=$((SCREEN_WIDTH - YAD_WIDTH - X_OFFSET))
pos_y=$((POLYBAR_HEIGHT + Y_OFFSET))

case "$1" in
--popup)
    yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
        --width="$YAD_WIDTH" --height="$YAD_HEIGHT" --posx="$pos_x" --posy="$pos_y" \
        --borders=0 >/dev/null &
    ;;
*)
    DATE="$(date +"%a %d %H:%M")"
    echo "$DATE"
    ;;
esac
