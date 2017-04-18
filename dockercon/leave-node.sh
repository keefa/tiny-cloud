#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

# leave workers
node=$1
if [ ! -z $node ]; then
  echo "Leave $node a worker"
  ip=$(ping -c 1 $prefix$node$suffix | grep PING | sed 's/^.*(//' | sed 's/).*$//')
  ssh $sshopts $user@$prefix$node$suffix docker swarm leave --force
fi
