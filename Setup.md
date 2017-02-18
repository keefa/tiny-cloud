# Setup

## Nodes

### Raspberry Pi 3

Download flash tool and flash latest HypriotOS to SD card.

```bash
curl -O https://raw.githubusercontent.com/hypriot/flash/master/$(uname -s)/flash
chmod +x flash
sudo mv flash /usr/local/bin/flash
flash --hostname orange https://github.com/hypriot/image-builder-rpi/releases/download/v1.2.0/hypriotos-rpi-v1.2.0.img.zip
```

SSH into the RPi. Update Docker if you like, enable ping

```bash
sudo apt-get update && sudo apt-get install docker-engine
sudo setcap cap_net_raw+ep /bin/ping
```

### UP Board

Download Ubuntu as described in
- https://up-community.org/downloads/ubuntu
- https://up-community.org/wiki/Ubuntu
- Write Ubuntu ISO to bootable USB stick
- Install Ubuntu
- Install UP kernel

```bash
sudo add-apt-repository ppa:ubilinux/up
sudo apt update
sudo apt install linux-upboard
sudo apt-get autoremove --purge 'linux-.*generic'
```
- Install AVAHI and SSH

```bash
sudo apt-get install -y avahi-daemon openssh-server
```

- Install Docker and Compose

```bash
curl -SsL https://get.docker.com | sudo sh
curl -L https://github.com/docker/compose/releases/download/1.11.1/docker-compose-`uname -s`-`uname -m` > docker-compose
chmod +x docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo gpasswd -a ${USER} docker
```

- Remove apparmor

The easiest way to make plossys/blinkt work without privileged to demo mulitarch swarm-mode.

```bash
sudo apt-get remove apparmor
```

