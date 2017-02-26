# Prepare Raspberry Pi 3

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
```

Now download flash tool and flash latest Raspbian with cloud-init support to SD card.

```bash
curl -O https://raw.githubusercontent.com/hypriot/flash/master/$(uname -s)/flash
chmod +x flash
sudo mv flash /usr/local/bin/flash
vi user-data
flash --hostname purple -u ./user-data https://github.com/sealsystems/pi-gen/releases/download/v1.3.3/image_2017-02-22-pi-cloud-lite.zip
```

The `flash` script overwrites the hostname in the `user-data` file, so you can just change the command to flash mulitple SD cards.

##### user-data template

To flash multiple "colored" boards, define a template for `user-data` with the filename `user-data.template.yml`. The placeholders `<color>` and `<ssh-key>` in the template file will be replaced by the actual data. Then run `flash-color.sh` and provide the color as a parameter.

To e.g. flash an "orange" board, type:

```bash
./flash-color.sh orange
```
