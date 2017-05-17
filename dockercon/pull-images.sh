#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

for node in $armNodes $intelNodes; do
  echo node $node
  ssh $sshopts $user@$ipSubnet.$node docker pull stefanscherer/monitor:1.1.0
  ssh $sshopts $user@$ipSubnet.$node docker pull stefanscherer/whoami:1.1.0
  ssh $sshopts $user@$ipSubnet.$node docker pull stefanscherer/whoami:1.2.0
  ssh $sshopts $user@$ipSubnet.$node docker pull sealsystems/visualizer:1.1.5
  ssh $sshopts $user@$ipSubnet.$node docker pull sealsystems/rainbow:0.2.0
  ssh $sshopts $user@$ipSubnet.$node docker pull sealsystems/rainbow:1.0.0
  ssh $sshopts $user@$ipSubnet.$node docker pull plossys/blinkt:0.7.2
done
