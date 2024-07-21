#!/usr/bin/env bash

alert_color="#ff4500"
normal_color="#f0c674"

# get load
cpu_load=$(vmstat 1 2 | tail -1 | awk '{ printf 100-$15; }')
mem_load=$(free -m | awk '/Mem/{printf("%.0f\n", $3/$2 * 100)}')
# sys_load=$(uptime | awk '{printf $(NF)}')

  # set color
  if [ "$cpu_load" -ge 90 ]; then
    cpu_color=$alert_color
  else
    cpu_color=$normal_color
  fi
  if [ "$mem_load" -ge 50 ]; then
    mem_color=$alert_color
  else
    mem_color=$normal_color
  fi

# echo outout
echo "%{F$cpu_color} %{F-}$cpu_load% %{F$mem_color} %{F-}$mem_load%"
