# Prepare UP board

Download Ubuntu as described in
- https://up-community.org/downloads/ubuntu
- https://up-community.org/wiki/Ubuntu
- Write Ubuntu ISO to bootable USB stick

## Add preseed files to USB stick

```
/usbstick/
  |
  - ks.cfg
  - ks.preseed
  - boot/
    |
    - grub/
      |
      - grub.cfg
```

- Adjust SSH public keys in `ks.cfg`
- Adjust hostname in `boot/grub/grub.cfg`

See also the blog post [Unattended Ubuntu installer USB drive, headless server](http://blog.p4i1.com/2014/09/unattended-ubuntu-installer-usb-drive.html)

Plug the USB stick into the UP board and turn it on.

You may need to press `F2` to enter BIOS once to adjust boot order to boot from USB stick. After that the installation works unattended.

You can ssh into as user `root`.
