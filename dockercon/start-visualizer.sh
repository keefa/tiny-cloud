#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
ssh="ssh $sshopts $user@$prefix$managerNode$suffix"

$ssh docker service rm visualizer || true
$ssh docker service create --name visualizer --publish 8080:8080 --constraint "node.role==manager" --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock sealsystems/visualizer:1.1.5
