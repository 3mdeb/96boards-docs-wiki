***
#### Your Build Choice

[<img src="http://i.imgur.com/jl4GG0d.png" data-canonical-src="http://i.imgur.com/jl4GG0d.png" width="125" height="157" />]()
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

#### Step 2: Download Debian partition table

> Note: Some files have 4G and 8G options, download file which best matches your HiKey board.

- All HiKey **CircuitCo boards** will use the **4G files**
- All HiKey **LeMaker 1G boards** will use the **4G files**
- All HiKey **LeMaker 2G boards** will use the **8G files**

**ptable-linux.img** ([**4G Download**](https://builds.96boards.org/releases/reference-platform/debian/hikey/16.03/bootloader/ptable-linux-4g.img) / [**8G Download**](https://builds.96boards.org/releases/reference-platform/debian/hikey/16.03/bootloader/ptable-linux-8g.img))

***

#### Step 3: Download Boot image and Root File System

- **Debian Boot** ([**Download**](https://builds.96boards.org/releases/reference-platform/debian/hikey/16.03/hikey-boot-linux-20160301-68.uefi.img.gz))
- **Debian Rootfs** (<a href="https://builds.96boards.org/releases/reference-platform/debian/hikey/16.03/hikey-rootfs-debian-jessie-alip-20160301-68.emmc.img.gz" target="_blank">**Download**</a>)


***

#### Step 4: Choose your host computer to access your instruction set

- [Linux](https://github.com/96boards/documentation/wiki/HiKey-Linux-Install#linux-host-1)


***

[<img src="http://i.imgur.com/znkTVHx.png" data-canonical-src="http://i.imgur.com/znkTVHx.png" width="125" height="300" />]()

***

#### Your Build Choice

[<img src="http://i.imgur.com/jl4GG0d.png" data-canonical-src="http://i.imgur.com/jl4GG0d.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/7wy1996.png" data-canonical-src="http://i.imgur.com/7wy1996.png" width="125" height="157" />]()
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

#### Step 2: Download the following files

>Note: Some files have 4G and 8G options, download file which best matches your HiKey board.

- All HiKey **CircuitCo boards** will use the **4G files**
- All HiKey **LeMaker 1G boards** will use the **4G files**
- All HiKey **LeMaker 2G boards** will use the **8G files**

Build Folders (<a href="http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/bootloader/" target="_blank">**Binaries**</a> / <a href="http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/" target="_blank">**Image**</a>)

- **l-loader.bin** ([**Download**](http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/bootloader/l-loader.bin))
- **fip.bin** ([**Download**](http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/bootloader/fip.bin))
- **nvme.img** ([**Download**](http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/bootloader/nvme.img))
- **ptable-aosp.img** ([**4G Download**](http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/bootloader/ptable-aosp-4g.img) / [**8G Download**](http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/bootloader/ptable-aosp-8g.img))
- **hisi-idt.py** ([**Download**](http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/bootloader/hisi-idt.py))
- **boot_fat.uefi.img** ([**Download**](http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/boot_fat.uefi.img.tar.xz))
- **cache.img.tar.xz** ([**Download**](http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/cache.img.tar.xz))
- **userdata.img.xz** ([**4G Download**](http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/userdata.img.tar.xz) / [**8G Download**](http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/userdata-8gb.img.tar.xz))
- **system.img.tar.xz** (<a href="http://builds.96boards.org/releases/reference-platform/aosp/hikey/16.03/system.img.tar.xz" target="_blank">**Download**</a>)

***

#### Step 3: Choose your host computer to access your instruction set

- [Linux](https://github.com/96boards/documentation/wiki/HiKey-Android-Install#linux-host)


***