# Setup

## Nodes

### Raspberry Pi 3

Download flash tool and flash latest HypriotOS

```bash
curl -O https://raw.githubusercontent.com/hypriot/flash/master/$(uname -s)/flash
chmod +x flash
sudo mv flash /usr/local/bin/flash
flash --hostname orange https://github.com/hypriot/image-builder-rpi/releases/download/v1.2.0/hypriotos-rpi-v1.2.0.img.zip
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

