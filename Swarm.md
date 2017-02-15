# Swarm

plossys/blinkt

## Portainer

```bash
docker service create \
  --name portainer \
  --publish 9000:9000 \
  --constraint 'node.role == manager' \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  portainer/portainer:1.11.3  \
  -H unix:///var/run/docker.sock
```

## Visualizer

```bash
docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
  -p 8080:8080 alexellis2/visualizer-arm:latest
```

## PLOSSYS Blinkt!

Problem: We need `--privileged`, https://github.com/docker/docker/issues/24862

```bash
docker service create --name=blinkt --with-registry-auth plossys/blinkt:latest
docker service scale blinkt=3
```
