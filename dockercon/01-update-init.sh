#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
ssh="ssh $sshopts $user@$prefix$managerNode$suffix"

$ssh docker service rm rainbow || true
$ssh docker service rm blinkt || true

$ssh docker service create --name rainbow --update-parallelism 2 --update-delay 3s --mount type=bind,src=/sys,dst=/sys sealsystems/rainbow:0.2.0
