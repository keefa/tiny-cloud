# Prepare UP board

Download Ubuntu as described in
- https://up-community.org/downloads/ubuntu
- https://up-community.org/wiki/Ubuntu
- Write Ubuntu ISO to bootable USB stick

## Add preseed files to USB stick

Copy the files in the `usb` sub folder onto the mounted USB stick.

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

You may need to press `ESC` to enter BIOS once to adjust boot order to boot from USB stick. After that the installation works unattended.

If you try it without a monitor, hold down `ESC` key for about 20 seconds.

Then follow these instructions to boot from USB stick and start the unattended installation.

- Press `ENTER` to enter the empty BIOS password.
- Press 4x `CURSOR RIGHT` to select the Boot configuration.
- Press 2x `CURSOR DOWN` to select Boot Option #1.
- Press `ENTER` to open the options.
- Press `PAGE UP` to select UEFI USB stick.
- Press `ENTER` to select the UEFI USB stick.
- Press `F4` to save and then press `ENTER` to exit the BIOS setup.
