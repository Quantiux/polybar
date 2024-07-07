#!/usr/bin/env bash

case "$1" in
    --clean)
        rm -rf ~/.local/share/Trash/expunged
        rm -rf ~/.local/share/Trash/files
        rm -rf ~/.local/share/Trash/info
        mkdir -p ~/.local/share/Trash/{expunged,files,info}
        ~/.config/polybar/scripts/notify-untitled.sh "Cleaning up..."
        ;;
    *)
        count=$(find ~/.local/share/Trash/files/* -maxdepth 0 2>/dev/null | wc -l)
        if [ "$count" -gt 0 ]; then
            echo "%{F#f0c674}%{F-} $count"
        else
            echo "%{F#f0c674}%{F-}"
        fi
        ;;
esac
