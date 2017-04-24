#!/bin/bash
docker service create --name monitor \
  --mode global --restart-condition any --mount type=bind,src=/sys,dst=/sys --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  stefanscherer/monitor:1.1.0

docker service create --name whoami stefanscherer/whoami:1.1.0
sleep 5
while true; do
  docker service scale whoami=7
  sleep 10
  docker service scale whoami=56
  sleep 20
  docker service update --update-parallelism 5 --image stefanscherer/whoami:1.2.0 whoami
  sleep 30
  docker service scale whoami=25
  sleep 5
  docker service scale whoami=56
  sleep 20
  docker service scale whoami=1
  sleep 5
  docker service update --update-parallelism 5 --image stefanscherer/whoami:1.1.0 whoami
  sleep 5
done
