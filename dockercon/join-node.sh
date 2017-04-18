#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

managerIP=$prefix$managerNode
workerToken=$(ssh $sshopts $user@$prefix$managerNode$suffix docker swarm join-token -q worker)
echo worker token: $workerToken

# join workers
node=$1
if [ ! -z $node ]; then
  echo "Make $node a worker"
  ip=$(ping -c 1 $prefix$node$suffix | grep PING | sed 's/^.*(//' | sed 's/).*$//')
  ssh $sshopts $user@$prefix$node$suffix docker swarm join --token $workerToken --advertise-addr $ip $managerIP:2377
fi
