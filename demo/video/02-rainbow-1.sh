#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
ssh="ssh $sshopts $user@$prefix$managerNode$suffix"

$ssh docker service rm rainbow || true
$ssh docker node update --availability=drain brown
$ssh docker node update --availability=drain green
$ssh docker node update --availability=drain magenta
$ssh docker node update --availability=drain orange
$ssh docker node update --availability=drain white
$ssh docker service create --name rainbow --constraint 'node.role==worker' --mount type=bind,src=/sys,dst=/sys sealsystems/rainbow:0.2.0
