#!/bin/bash

color=$1

if [ -z ${color} ]; then
  echo "Usage: $0 <color of board to flash>"
  exit 1
fi

key="$(cat ~/.ssh/id_rsa.pub)"

sed "s|<color>|${color}|" user-data.template.yml | sed "s|<user>|${USER}|" | sed "s|<ssh-key>|${key}|" > user-data.generated

flash --hostname ${color} -u ./user-data.generated https://github.com/sealsystems/pi-gen/releases/download/v1.3.3/image_2017-02-22-pi-cloud-lite.zip
