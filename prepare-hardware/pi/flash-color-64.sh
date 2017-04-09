#!/bin/bash

color=$1
user=$2

if [ -z ${user} ]; then
  user=${USER}
fi

if [ -z ${color} ]; then
  echo "Usage: $0 <color of board to flash> [<username>]"
  exit 1
fi

key="$(cat ~/.ssh/id_rsa.pub)"
arch="arm64"
sed "s|<color>|${color}|" user-data.template.yml | sed "s|<user>|${user}|" | sed "s|<ssh-key>|${key}|" | sed "s|<arch>|${arch}|"> user-data.generated

flash --hostname ${color} -u ./user-data.generated https://github.com/sealsystems/image-builder-rpi64/releases/download/v1.0.1/hypriotos-rpi64-v1.0.1.img.zip
