## Docker swarm manager on node red

This demo works with a Pi/UP cluster built with IP addresses 192.168.17.101 ... 107
running the Docker swarm manager on node "red" (IP 106) with the `picloud.service`
installed to bootstrap a new Docker Swarm after turning on the power supply.
See the folder `red` for the `picloud-bootstrap.sh` script and also pre-pull all
images on all nodes to run the demo without Internet connection.

Also create Docker TLS certs once for node `red` so it listens on port 2376
and update the windows/bin/certs folder

```
docker-machine create -d generic --generic-ip-address 192.168.17.106     --generic-ssh-user pirate red
```
