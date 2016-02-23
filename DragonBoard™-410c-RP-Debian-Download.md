[<<< Back to DragonBoard™ 410c Home](https://github.com/96boards/documentation/wiki/DragonBoard™-410c-Home)

***
#### Your Build Choice

[<img src="http://i.imgur.com/jl4GG0d.png" data-canonical-src="http://i.imgur.com/jl4GG0d.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/OQGR5yY.png" data-canonical-src="http://i.imgur.com/OQGR5yY.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()

***
#### Choose your Method of Installation

[<img src="http://i.imgur.com/tXXN5bZ.png" data-canonical-src="http://i.imgur.com/tXXN5bZ.png" width="125" height="157" />](https://github.com/96boards/documentation/wiki/DragonBoard™-410c-Linaro-Debian-Download#your-build-choice-2)

## Fastboot Method
Fastboot is supported by the board and can be used for installs.  This is for advanced users who are most likely modifying/customizing source code and will need to download such updates to the board for test/execution. When installing Debian using Fastboot, you will have the option to install either the Developer(console-only) image, or the LXDE(Desktop) image.  

> **Note:** When installing Debian using the SD Card method, LXDE(Desktop) install is currently the only option,  Fastboot is the only way to attain a Console-only Debian install.

This method requires the following hardware:
- DragonBoard™ 410c with power supply
- Host machine (Linux, Mac OS X, or Windows)
- USB to microUSB cable
- USB Mouse and/or keyboard (not required to perform flash)
- HDMI Monitor with full size HDMI cable (not required to perform flash)

***


[<img src="http://i.imgur.com/znkTVHx.png" data-canonical-src="http://i.imgur.com/znkTVHx.png" width="125" height="300" />]()



***
#### Your Build Choice

[<img src="http://i.imgur.com/jl4GG0d.png" data-canonical-src="http://i.imgur.com/jl4GG0d.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/OQGR5yY.png" data-canonical-src="http://i.imgur.com/OQGR5yY.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/tXXN5bZ.png" data-canonical-src="http://i.imgur.com/tXXN5bZ.png" width="125" height="157" />]()

***

#### Step 1: Download Debian Bootloader and Boot file

- Debian Bootloader ([Direct Download](http://builds.96boards.org/releases/dragonboard410c/linaro/rescue/latest/dragonboard410c_bootloader_emmc_linux*.zip) / <a href="http://builds.96boards.org/releases/dragonboard410c/linaro/rescue/latest/" target="_blank">Build Folder</a> )
- Debian Boot ([Direct Download](http://builds.96boards.org/releases/reference-platform/debian/dragonboard410c/15.12/dragonboard410c-boot-linux-20151214-35.img.gz) / <a href="http://builds.96boards.org/releases/reference-platform/debian/dragonboard410c/15.12/" target="_blank">Build Folder</a> )

#### Step 2: Download Root File System

- Debian Rootfs (Desktop) ([Direct Download](http://builds.96boards.org/releases/reference-platform/debian/dragonboard410c/15.12/dragonboard410c-rootfs-debian-jessie-alip-20151214-35.emmc.img.gz) / <a href="http://builds.96boards.org/releases/reference-platform/debian/dragonboard410c/15.12/" target="_blank">Build Folder</a> )

***
#### Step 3: Choose your host computer to access your instruction set

- [Linux](https://github.com/96boards/documentation/wiki/DragonBoard™-410c-Linux-Install#linux-host-1)
- [Mac OS X](https://github.com/96boards/documentation/wiki/DragonBoard™-410c-Linux-Install#mac-osx-host)

***