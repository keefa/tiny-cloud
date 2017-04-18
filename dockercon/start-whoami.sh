#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/nodes.config
sshopts="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
ssh="ssh $sshopts $user@$prefix$managerNode$suffix"

$ssh docker service rm whoami || true
$ssh docker service create --name whoami --publish 8000:8000 --env PORT=8000 stefanscherer/whoami:1.2.0
