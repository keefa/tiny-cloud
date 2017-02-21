# Setup

## Nodes

### Raspberry Pi 3

Create a `user-data` file to customize the Raspberry Pi on first boot.

```yaml
#cloud-config
hostname: purple
manage_etc_hosts: true
users:
  - name: pi
    primary-group: users
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users,docker,adm,dialout,audio,plugdev,netdev,video,spi,i2c,gpio
    ssh-import-id: None
    lock_passwd: true
    ssh-authorized-keys:
      - ssh-rsa AAAAB3Nz...vuz3YRmWNN
write_files:
-   content: |
        {
          "labels": [ "os=linux", "arch=arm" ],
          "experimental": true
        }
    owner: root:root
    path: /etc/docker/daemon.json
runcmd:
 - [ systemctl, restart, avahi-daemon ]
 - [ systemctl, restart, docker ]
 - [ docker, pull, plossys/blinkt ]
 - [ docker, pull, sealsystems/visualizer:latest-arm ]
```

Now download flash tool and flash latest Raspbian with cloud-init support to SD card.

```bash
curl -O https://raw.githubusercontent.com/hypriot/flash/master/$(uname -s)/flash
chmod +x flash
sudo mv flash /usr/local/bin/flash
vi user-data
flash --hostname purple -u ./user-data https://github.com/StefanScherer/pi-gen/releases/download/v1.2.0/image_2017-02-21-Raspbian-lite.zip
```

The `flash` script overwrites the hostname in the `user-data` file, so you can just change the command to flash mulitple SD cards.

##### user-data template

To flash multiple "colored" boards, define a template for `user-data` with the filename `user-data.template.yml`. The placeholders `<color>` and `<ssh-key>` in the template file will be replaced by the actual data. Then run `flash-color.sh` and provide the color as a parameter.

To e.g. flash an "orange" board, type:

```bash
./flash-color.sh orange
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
