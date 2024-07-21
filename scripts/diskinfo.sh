#!/usr/bin/env bash

# Function to get percentage used for a partition
alert_color="#ff4500"
normal_color="#f0c674"
get_partition_usage() {
    partition="$1"
    df -h | grep -w "$partition" | awk '{print $5}' | sed 's/%//'
}

# Get usage for root (/) and home (/home) partitions
root_usage=$(get_partition_usage '/dev/nvme0n1p2')
home_usage=$(get_partition_usage '/dev/nvme0n1p4')

# set color
if [ "$root_usage" -ge 80 ]; then
  root_color=$alert_color
else
  root_color=$normal_color
fi
if [ "$home_usage" -ge 80 ]; then
  home_color=$alert_color
else
  home_color=$normal_color
fi

# Print the usage in the format required by Polybar
echo "%{F$root_color}/%{F-}$root_usage% %{F$home_color}/%{F-} $home_usage%"
