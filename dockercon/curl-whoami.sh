#!/bin/bash
command="curl http://192.168.17.102:8000"
echo "Running $command"
while [ true ]; do
  $command
  sleep 0.5
done
