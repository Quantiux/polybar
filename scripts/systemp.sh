#!/usr/bin/env bash

# sensors output depends on hardware (your mileage may vary)
alert_color="#ff4500"
normal_color="#f0c674"
fan_color="#ff7352"
host=$(hostname)
if [ "$host" = "Nbook" ]; then

  # get temperature
  cpu_temp=$(sensors | awk '/CPU/{printf "%.0f\n", $2}')
  # gpu_temp=$(sensors | awk '/edge/{printf "%.0f°C\n", $2}')
  mem_temp=$(sensors | awk '/SODIMM/{printf "%.0f\n", $2}')
  ssd_temp=$(sensors | awk '/Composite/{printf "%.0f\n", $2}')
  # get fan speed
  fan_speed=$(sensors | grep 'Processor Fan:' | awk '{print $3}')
  
  # set color
  if [ "$cpu_temp" -ge 90 ]; then
    cpu_color=$alert_color
  else
    cpu_color=$normal_color
  fi
  if [ "$mem_temp" -ge 55 ]; then
    mem_color=$alert_color
  else
    mem_color=$normal_color
  fi
  if [ "$ssd_temp" -ge 50 ]; then
    ssd_color=$alert_color
  else
    ssd_color=$normal_color
  fi
  
  # echo outout
  if [ "$fan_speed" -gt 0 ]; then
    echo "%{F$cpu_color} %{F-}$cpu_temp°C %{F$mem_color} %{F-}$mem_temp°C %{F$ssd_color} %{F-}$ssd_temp°C %{F$fan_color} %{F-}$fan_speed RPM"
  else
    echo "%{F$cpu_color} %{F-}$cpu_temp°C %{F$mem_color} %{F-}$mem_temp°C %{F$ssd_color} %{F-}$ssd_temp°C"
  fi
  
elif [ "$host" = "PC" ]; then

  cpu_temp=$(sensors | awk '/Package id 0/{printf "%.0f\n", $4}')
  gpu_temp=$(sensors | grep temp1 | awk 'NR==2 {printf "%.0f\n", $2}')
  hdd_temp=$(hddtemp /dev/sda | awk '{printf "%.0f\n", $4}')
  
  if [ "$cpu_temp" -ge 90 ]; then
    cpu_color=$alert_color
  else
    cpu_color=$normal_color
  fi
  if [ "$gpu_temp" -ge 90 ]; then
    gpu_color=$alert_color
  else
    gpu_color=$normal_color
  fi
  if [ "$hdd_temp" -ge 50 ]; then
    hdd_color=$alert_color
  else
    hdd_color=$normal_color
  fi

  echo "%{F$cpu_color} %{F-}$cpu_temp°C %{F$gpu_color}﬙ %{F-}$gpu_temp°C %{F$hdd_color} %{F-}$hdd_temp°C"
else
  echo "Unknown host"
fi
