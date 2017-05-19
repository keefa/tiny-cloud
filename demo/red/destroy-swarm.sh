#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

for node in $managerNode $managerNodes $workerNodes 117; do
  ssh $sshopts $user@$prefix$node$suffix docker swarm leave -f &
done

sleep 5
for node in $managerNode $managerNodes; do
  ssh $sshopts $user@$prefix$node$suffix sudo systemctl restart docker &
done
