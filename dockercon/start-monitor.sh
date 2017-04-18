#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
ssh="ssh $sshopts $user@$prefix$managerNode$suffix"

$ssh docker service rm rainbow || true
$ssh docker service rm blinkt || true

$ssh docker service create --name monitor \
--mode global --restart-condition any --mount type=bind,src=/sys,dst=/sys --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
stefanscherer/monitor:1.1.0
