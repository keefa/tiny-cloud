# Swarm 2 Go demo at DockerCon 2017

This folder contains all scripts I used to run the demo at DockerCon 2017.

## Preparation

Boot up all nodes, ping them if they are up.

Sync clocks for the Raspberry Pi nodes as they do not have a battery backuped realtime clock.

```
./set-hwclock.sh
```

Create the Docker swarm with seven nodes.

```bash
./create-swarm.sh
```

Start the Docker Swarm visualizer

```bash
./start-visualizer.sh
```

Open a browser with the visualizer

```bash
./open-visualizer.sh
```

## Run rainbow demo

Create a service with one replica running the rainbow app.

```bash
docker service create --name rainbow --mount type=bind,src=/sys,dst=/sys sealsystems/rainbow:0.2.0
```

Scale up to three nodes

```bash
docker service scale rainbow=3
```

Play around with power outage for one node and then drop the network connection of one of the nodes that is running the rainbow app.

# Scale up

Switch to another LED visualizer that shows one LED per container so you can scale up to 56 replicas.

```bash
./start-monitor.sh
```

Create the whoami service

```bash
docker service create --name whoami stefanscherer/whoami:1.1.0
```

Scale up to 7 to show one container per node.

```bash
docker service scale whoami=7
```

Now scale up!!!

```bash
docker service scale whoami=56
```

Now demo the rolling update, probably during constantly accessing the whoami service from the outside to demo that the service is available during the whole rolling update.

```bash
docker service update --update-parallelism 5 --image stefanscherer/whoami:1.2.0 whoami
```

Now scale down again to demo visualization.

```bash
docker servcie scale whoami=7
docker servcie scale whoami=1
```

Thank you!
