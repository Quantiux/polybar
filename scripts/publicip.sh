#!/usr/bin/env bash

if ping -q -c 1 -W 1 8.8.8.8 > /dev/null 2>&1; then
  IP=$(curl -4 -sf ifconfig.co)
  if [ -z "$IP" ]; then
    echo "IP unavailable"
  else
    echo "$IP"
  fi
else
  echo "No connection"
fi
