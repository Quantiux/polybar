#!/usr/bin/env bash

updates=$(apt-get dist-upgrade -s --quiet=2 | grep ^Inst | wc -l)

if [ "$updates" -gt 0 ]; then
    echo "%{F#f0c674}%{F-} $updates"
else
    echo "%{F#00ff00}%{F-}"
fi
