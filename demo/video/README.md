# Tiny Cloud video shot


01-start-rainbow-7.sh
02-rainbow-1.sh
03-update-scale-3.sh
04-init-for-rolling-update.sh
05-rolling-update.sh

## Preparation
```
./00-create-swarm.sh
```

Start rainbow on all 7 nodes

```bash
./01-start-rainbow-7.sh
```

## Failover

Scale down to one node

```bash
./02-rainbow-1.sh
```

Scale up to three nodes for failover, first three nodes show up LED's.

```bash
./03-update-scale-3.sh
```

Now unplug eg. second node. The fourth will show up LED's soon.

## Rolling Update

```bash
./04-init-for-rolling-update.sh
```

Now do the rolling update

```bash
05-rolling-update.sh
```

Thank you!
