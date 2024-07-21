#!/usr/bin/env bash

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
        YAD_WIDTH=410
        pos_x=$((SCREEN_WIDTH - YAD_WIDTH - X_OFFSET))
        pos_y=$((POLYBAR_HEIGHT + Y_OFFSET))

        yad --width="$YAD_WIDTH" --posx="$pos_x" --posy="$pos_y" --close-on-unfocus --buttons-layout=center --undecorated --title "System Logout" --image=gnome-shutdown \
            --text "<span size='large'><b>Choose action:</b></span>" \
            --button="Logout:1" --button="Reboot:2" --button="Shutdown:3" --button="Suspend:4"
        
        choice=$?

        case "$choice" in
            1)
                awesome-client "awesome.quit()"
                ;;
            2)
                reboot
                ;;
            3)
                poweroff
                ;;
            4)
                hibernate
                ;;
        esac
        ;;
    *)
        echo "%{F#f0c674}%{F-}"
        ;;
esac

