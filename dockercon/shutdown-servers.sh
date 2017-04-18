#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

for node in $armNodes; do
  ssh $sshopts $user@$prefix$node$suffix sudo shutdown -P now &
done

for node in $intelNodes; do
  ssh $sshopts $user@$prefix$node$suffix sudo shutdown -P now &
done
