***

#### Your Build Choice

[<img src="http://i.imgur.com/7rrS2JR.png" data-canonical-src="http://i.imgur.com/7rrS2JR.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/OQGR5yY.png" data-canonical-src="http://i.imgur.com/OQGR5yY.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/g8N21m1.png" data-canonical-src="http://i.imgur.com/g8N21m1.png" width="125" height="157" />]()

[<<< Back to HiKey Crossroads](https://github.com/96boards/documentation/wiki/HiKey-Crossroads)

***
#### Step 1: Read about the SD Card Method

The SD card method allows you to place a microSD card into the DragonBoard™ 410c to automatically boot and install the Linux Desktop onto the board. This method is generally simpler and should be used by beginners. 

This method requires the following hardware:
- HiKey with power supply
- Host machine (Linux, Mac OS X, or Windows)
- MicroSD card with 4GB or more of storage
- USB Mouse and/or keyboard
- HDMI Monitor with full size HDMI cable 


***
#### Step 2: Download SD Card Image

> Note: Choose 4G or 8G option, download file which best matches your HiKey board.

- **Debian SD Card Image** ([**4G Download**](https://builds.96boards.org/releases/hikey/linaro/debian/latest/hikey-jessie_alip_20151130-387-4g.emmc.img.gz) / [**8G Download**](https://builds.96boards.org/releases/hikey/linaro/debian/latest/hikey-jessie_alip_20151130-387-8g.emmc.img.gz))

***
#### Step 3: Choose your host computer to access your instruction set

- [Linux](https://github.com/96boards/documentation/wiki/HiKey-Linux-Install#linux-host)
- [Mac OS X](https://github.com/96boards/documentation/wiki/HiKey-Linux-Install#mac-os-x-host)
- [Windows](https://github.com/96boards/documentation/wiki/HiKey-Linux-Install#windows-host)

***

[<img src="http://i.imgur.com/znkTVHx.png" data-canonical-src="http://i.imgur.com/znkTVHx.png" width="125" height="300" />]()



***

#### Your Build Choice

[<img src="http://i.imgur.com/7rrS2JR.png" data-canonical-src="http://i.imgur.com/7rrS2JR.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/OQGR5yY.png" data-canonical-src="http://i.imgur.com/OQGR5yY.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/tXXN5bZ.png" data-canonical-src="http://i.imgur.com/tXXN5bZ.png" width="125" height="157" />]()

[<<< Back to HiKey Crossroads](https://github.com/96boards/documentation/wiki/HiKey-Crossroads)

***
#### Step 1: Read about the Fastboot Method

Fastboot is supported by the board and can be used for installs.  This is for advanced users who are most likely modifying/customizing source code and will need to download such updates to the board for test/execution. 

This method requires the following hardware:
- HiKey with power supply
- Host machine (Linux, Mac OS X, or Windows)
- USB to microUSB cable
- USB Mouse and/or keyboard (not required to perform flash)
- HDMI Monitor with full size HDMI cable (not required to perform flash)

***

#### Step 2: Download Debian Bootloader and Boot file

> Note: Some files have 4G and 8G options, download file which best matches your HiKey board.

Build Folders (<a href="http://builds.96boards.org/releases/hikey/linaro/binaries/latest/" target="_blank">**Binaries**</a> / <a href="http://builds.96boards.org/releases/hikey/linaro/debian/latest/" target="_blank">**Image**</a>)

- **l-loader.bin** ([**Download**](http://builds.96boards.org/releases/hikey/linaro/binaries/latest/l-loader.bin))
- **fip.bin** ([**Download**](http://builds.96boards.org/releases/hikey/linaro/binaries/latest/fip.bin))
- **nvme.img** ([**Download**](http://builds.96boards.org/releases/hikey/linaro/binaries/latest/nvme.img))
- **ptable-linux.img** ([**4G Download**](http://builds.96boards.org/releases/hikey/linaro/debian/latest/ptable-linux-4g.img) / [**8G Download**](http://builds.96boards.org/releases/hikey/linaro/debian/latest/ptable-linux-8g.img))
- **hisi-idt.py** ([**Download**](http://builds.96boards.org/releases/hikey/linaro/binaries/latest/hisi-idt.py))
- **boot_fat.uefi.img** ([**Download**](http://builds.96boards.org/releases/hikey/linaro/debian/latest/boot-fat.uefi.img.gz))

#### Step 3: Download ONE Root File System

> Note: Some files have 4G and 8G options, download file which best matches your HiKey board.

- **Debian Rootfs (Desktop)** (<a href="http://builds.96boards.org/releases/hikey/linaro/debian/latest/hikey-jessie_alip_20151130-387-4g.emmc.img.gz" target="_blank">**4G Download**</a> / <a href="http://builds.96boards.org/releases/hikey/linaro/debian/latest/hikey-jessie_alip_20151130-387-8g.emmc.img.gz" target="_blank">**8G Download**</a>)
- **Debian Rootfs (Command line)** (<a href="http://builds.96boards.org/releases/hikey/linaro/debian/latest/hikey-jessie_developer_20151130-387-4g.emmc.img.gz" target="_blank">**4G Download**</a> / <a href="http://builds.96boards.org/releases/hikey/linaro/debian/latest/hikey-jessie_developer_20151130-387-8g.emmc.img.gz" target="_blank">**8G Download**</a>)

***

#### Step 3: Choose your host computer to access your instruction set

- [Linux]()
- [Mac OS X]()

***