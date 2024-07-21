#!/usr/bin/env bash

PATH_AC="/sys/class/power_supply/ACAD"
PATH_BATTERY="/sys/class/power_supply/BAT1"

ac=0
battery_level=0
battery_max=0
if [ -f "$PATH_AC/online" ]; then
    ac=$(cat "$PATH_AC/online")
fi
if [ -f "$PATH_BATTERY/charge_now" ]; then
    battery_level=$(cat "$PATH_BATTERY/charge_now")
fi
if [ -f "$PATH_BATTERY/charge_full" ]; then
    battery_max=$(cat "$PATH_BATTERY/charge_full")
fi
battery_percent=$(("$battery_level * 100 / $battery_max"))

charging_color="#00FF00"
discharging_color="#f0c674"
alert_color="#ff4500"
if [ "$ac" -eq 1 ]; then
    if [ "$battery_percent" -gt 97 ]; then
        echo "%{F$charging_color}󰁹%{F-}"
    elif [ "$battery_percent" -gt 50 ]; then
        echo "%{F$charging_color}󰁿%{F-} $battery_percent%"
    else
        echo "%{F$charging_color}󰁼%{F-} $battery_percent%"
    fi
else
    if [ "$battery_percent" -gt 97 ]; then
        echo "%{F$discharging_color}󰁹%{F-}"
    elif [ "$battery_percent" -gt 50 ]; then
        echo "%{F$discharging_color}󰁿%{F-} $battery_percent%"
    elif [ "$battery_percent" -gt 20 ]; then
        echo "%{F$discharging_color}󰁼%{F-} $battery_percent%"
    else
        echo "%{F$alert_color}󰂎%{F-} $battery_percent%"
    fi
fi
