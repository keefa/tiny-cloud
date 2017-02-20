#!/bin/bash

color=$1

if [ -z ${color} ]; then
  echo "Usage: $0 <color of board to flash>"
  exit 1
fi

key="$(cat ~/.ssh/id_rsa.pub | cut -d' ' -f2)"

sed "s|<color>|${color}|" user-data.template | sed "s|<ssh-key>|${key}|" > user-data.generated

flash --hostname ${color} -u ./user-data.generated https://github.com/StefanScherer/image-builder-rpi/releases/download/v1.4.0/hypriotos-rpi-v1.4.0.img.zip
