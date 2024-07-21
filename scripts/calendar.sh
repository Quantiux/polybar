#!/usr/bin/env bash

# display calendar with today's date highlighted

case "$1" in
--popup)

    # get screen dimensions
    SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f1)
    SCREEN_HEIGHT=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f2)

    # offsets
    POLYBAR_HEIGHT=16  # polybar height in pixels
    X_OFFSET=10  # offset from polybar's right edge
    Y_OFFSET=2  # offset from polybar's bottom

    # calculate popup position
    YAD_WIDTH=222
    pos_x=$((SCREEN_WIDTH - YAD_WIDTH - X_OFFSET))
    pos_y=$((POLYBAR_HEIGHT + Y_OFFSET))

    yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
        --width="$YAD_WIDTH" --posx="$pos_x" --posy="$pos_y" \
        --borders=0 >/dev/null &
    ;;
*)
    DATE="$(date +"%a %d %H:%M")"
    echo "$DATE"
    ;;
esac
