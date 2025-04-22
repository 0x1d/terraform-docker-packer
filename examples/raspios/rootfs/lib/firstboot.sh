#!/usr/bin/env bash

# Generate a unique hostname
NEW_HOSTNAME="rpi-$(cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2 | tail -c 5)"
echo "$NEW_HOSTNAME" > /etc/hostname
sed -i "s/raspberrypi/$NEW_HOSTNAME/g" /etc/hosts
hostname "$NEW_HOSTNAME"