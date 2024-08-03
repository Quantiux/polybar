#!/usr/bin/env bash

# Get available updates and their count
updates=$(mintupdate-cli list)
count=$(echo $($updates | wc -l))

# Display updates count on Polybar
if [ "$count" -gt 0 ]; then
    echo "%{F#f0c674}%{F-} $count"
else
    echo "%{F#00ff00}%{F-}"
fi

# Do this if the script is called with a 'show' argument (click-left action)
if [ "$1" == "show" ]; then

    # get screen dimensions
    SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f1)
    SCREEN_HEIGHT=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f2)

    # offsets
    POLYBAR_HEIGHT=16  # polybar height in pixels
    X_OFFSET=660  # offset from polybar's right edge
    Y_OFFSET=2  # offset from polybar's bottom

    # calculate popup position
    pos_x=$((SCREEN_WIDTH - X_OFFSET))
    pos_y=$((POLYBAR_HEIGHT + Y_OFFSET))

    # Check if there are any updates available
    if [ "$count" -gt 0 ]; then
        # Show update list
        yad --text="<span size='large'><b>Available updates: </b></span>\n$updates" --posx="$pos_x" --posy="$pos_y" --no-buttons --undecorated --close-on-unfocus
    else
        # Show Mint's "Up-to-date" icon
        yad --image=mintupdate-up-to-date --posx="$pos_x" --posy="$pos_y" --no-buttons --undecorated --close-on-unfocus
    fi
fi
