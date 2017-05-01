# UP Board with Windows Server 2016

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

The most part of the following steps are from Patrick Lang's gist https://gist.github.com/PatrickLang/820aa9e8c60654da051c139fb245fae8
Thanks Patrick for all the details.

Thanks to the blog post http://www.thomasmaurer.ch/2016/10/create-a-usb-stick-for-windows-server-2016-installation/ I found a way to put the big wim file onto a FAT32 USB stick.
We have to split it.

```
mkdir c:\cache
copy C:\vagrant\resources\en_windows_server_2016_x64_dvd_9718492.iso c:\cache\win2016.iso
copy C:\vagrant\resources\windows10.0-kb4015217-x64_60bfcc7b365f9ab40608e2fb96bc2be8229bc319.msu c:\cache\kb401521.msu

# mount ISO
$mountResult = Mount-DiskImage (get-item c:\cache\win2016.iso).FullName -PassThru
$drive = ($mountResult | Get-Volume).DriveLetter + ":"

mkdir c:\temp # Temporary copy of drivers to install
mkdir c:\slipstream # Working directory for customizing the Windows image
cd c:\slipstream
robocopy /s /e $drive\ extracted
cd C:\slipstream\extracted\sources

# Mount server core datacenter installation media
mkdir c:\slipstream\mount\boot
mkdir c:\slipstream\mount\install
# Make install.wim writable
Get-Item install.wim | Set-ItemProperty -Name IsReadOnly -Value $false
dism.exe /mount-wim /wimfile:install.wim /index:3 /mountdir:c:\slipstream\mount\install

# Mount boot media
dism.exe /mount-wim /wimfile:boot.wim /index:2 /mountdir:c:\slipstream\mount\boot /readonly

# Copy drivers from boot media to temp
cd c:\slipstream\mount
copy .\boot\windows\inf\sd* c:\temp
copy .\boot\windows\system32\drivers\sd* c:\temp
copy .\boot\windows\system32\drivers\dumpsd.sys c:\temp

# Add the latest cumulative update
dism.exe /image:install /add-package:"c:\cache\kb4015217.msu"

# Add drivers to server core media
dism.exe /image:install /add-driver /driver:"C:\temp"  /forceunsigned /recurse

# Unmount images
dism.exe /unmount-wim /mountdir:c:\slipstream\mount\boot /discard
dism.exe /unmount-wim /mountdir:c:\slipstream\mount\install /commit

# drive letter of USB stick
$usb = 'J:'

# Split install.wim
cd C:\slipstream
mv .\extracted\sources\install.wim install.wim

# Copy ISO to USB
robocopy /s /e extracted $usb\

# Split install.wim for FAT32 on USB
dism /Split-Image /ImageFile:install.wim /SWMFile:$usb\sources\install.swm /FileSize:4096
```

## Boot from USB

Plug in the USB stick, turn on the UP board and press `ESC` for some seconds. Enter BIOS and select the USB stick as first boot device.

In the partition dialog delete all previous (eg. Linux) partitions and create a new one. It will create all partitions needed to install Windows Server 2016.
Answer the few questions and select the Windows Server 2016 Datacenter (third row).
