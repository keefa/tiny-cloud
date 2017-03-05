# UP Board with Windows 10

## Create a bootable USB disk

https://technet.microsoft.com/en-us/library/dn621902.aspx

```
PS C:\Users\vagrant> diskpart

Microsoft DiskPart version 10.0.15031.0

Copyright (C) Microsoft Corporation.
On computer: VAGRANT-10

DISKPART> list disk

  Disk ###  Status         Size     Free     Dyn  Gpt
  --------  -------------  -------  -------  ---  ---
  Disk 0    Online           60 GB      0 B

DISKPART> list disk

  Disk ###  Status         Size     Free     Dyn  Gpt
  --------  -------------  -------  -------  ---  ---
  Disk 0    Online           60 GB      0 B
  Disk 1    Online           30 GB      0 B

DISKPART> select disk 1

Disk 1 is now the selected disk.

DISKPART> clean

DiskPart succeeded in cleaning the disk.

DISKPART> create partition primary

DiskPart succeeded in creating the specified partition.

DISKPART> format quick fs=fat32 label="Setup x64"

  100 percent completed

DiskPart successfully formatted the volume.

DISKPART> active

DiskPart marked the current partition as active.

DISKPART> assign letter="J"

DiskPart successfully assigned the drive letter or mount point.

DISKPART> exit

Leaving DiskPart...
```

## Copy files

```
PS C:\Users\vagrant> copy C:\vagrant\iso\15031.0.170204-1546.RS2_RELEASE_CLIENTPRO-CORE_OEMRET_X64FRE_EN-US.ISO .\Desktop\

# mount ISO as drive E:

PS C:\Users\vagrant> xcopy E:\*.* J:\ /E /H /F
```

## Prepare Autounattend.xml

- Adjust the `ComputerName` in `Autounattend.xml`
- Adjust the username `demouser` in `Autounattend.xml`
- Adjust the password `Passw0rd!` in `Autounattend.xml`
- Add SSH public keys in `scripts\authorized_keys`.

```
/usbstick/
  |
  - Autounattend.xml
  - scripts/
    |
    - authorized_keys
```

At the moment the partioning does not work automatically. You have to comment out that tag and use the dialog boxes.
