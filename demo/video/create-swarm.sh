#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

# create first manager
echo "Make $managerNode the first manager"
managerIP=$prefix$managerNode
echo manager IP: $managerIP
ssh $sshopts $user@$prefix$managerNode$suffix docker swarm init --advertise-addr $managerIP
managerToken=$(ssh $sshopts $user@$prefix$managerNode$suffix docker swarm join-token -q manager)
echo manager token: $managerToken
workerToken=$(ssh $sshopts $user@$prefix$managerNode$suffix docker swarm join-token -q worker)
echo worker token: $workerToken

# create other managers
for node in $managerNodes; do
 echo "Make $node a manager"
 ip=$(ping -c 1 $prefix$node$suffix | grep PING | sed 's/^.*(//' | sed 's/).*$//')
 ssh $sshopts $user@$prefix$node$suffix docker swarm join --token $managerToken --advertise-addr $ip $managerIP:2377
done

# create workers
for node in $workerNodes; do
  echo "Make $node a worker"
  ip=$(ping -c 1 $prefix$node$suffix | grep PING | sed 's/^.*(//' | sed 's/).*$//')
  ssh $sshopts $user@$prefix$node$suffix docker swarm join --token $workerToken --advertise-addr $ip $managerIP:2377
done
