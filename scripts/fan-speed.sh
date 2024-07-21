#!/usr/bin/env bash

fan_speed=$(sensors | grep 'Processor Fan:' | awk '{print $3}')

echo "$fan_speed RPM"
