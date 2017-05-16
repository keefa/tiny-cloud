#!/bin/bash

echo "Wait for Docker engine"
while [ "$(netstat -an | grep 2376)" == "" ]; do
  sleep 1
done

sleep 10

docker swarm leave -f
docker swarm leave -f

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

echo "Leaving all swarm nodes"
for node in $managerNodes $workerNodes; do
  ssh $sshopts $user@$prefix$node$suffix docker swarm leave -f &
done

sleep 15

echo "Setting fake-hwclock on all Raspberry Pi's"
for node in $allPiNodes; do
  date=$(date "+%Y-%m-%d %H:%M:%S")
  echo "$date" | ssh $sshopts $user@$ipSubnet.$node bash -c \"sudo tee /etc/fake-hwclock.data \&\& sudo fake-hwclock load\"
done

echo "Create new Docker swarm"
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

echo "Start Visualizer"
ssh $sshopts $user@$prefix$managerNode$suffix docker service rm visualizer || true
ssh $sshopts $user@$prefix$managerNode$suffix docker service create --name visualizer --publish 8080:8080 --constraint "node.role==manager" --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock sealsystems/visualizer:1.1.5

echo "Start Rainbow"
ssh $sshopts $user@$prefix$managerNode$suffix docker service create --replicas 3 --name rainbow --update-parallelism 2 --update-delay 3s --mount type=bind,src=/sys,dst=/sys sealsystems/rainbow:0.2.0
