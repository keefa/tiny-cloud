#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

for node in $allPiNodes; do
  date=$(ssh $sshopts $user@$ipSubnet.$piClockNode date \"+%Y-%m-%d %H:%M:%S\")
  echo "$date" | ssh $sshopts $user@$ipSubnet.$node bash -c \"sudo tee /etc/fake-hwclock.data \&\& sudo fake-hwclock load\"
done
