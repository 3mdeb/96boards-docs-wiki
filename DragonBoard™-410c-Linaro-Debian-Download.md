***

#### Your Build Choice

[<img src="http://i.imgur.com/7rrS2JR.png" data-canonical-src="http://i.imgur.com/7rrS2JR.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/OQGR5yY.png" data-canonical-src="http://i.imgur.com/OQGR5yY.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/g8N21m1.png" data-canonical-src="http://i.imgur.com/g8N21m1.png" width="125" height="157" />]()

[<<< Back to DragonBoard™ 410c Crossroads](https://github.com/96boards/documentation/wiki/DragonBoard™-410c-Crossroads)

***
#### Step 1: Read about the SD Card Method

The SD card method allows you to place a microSD card into the DragonBoard™ 410c to automatically boot and install the Linux Desktop onto the board. This method is generally simpler and should be used by beginners. 

This method requires the following hardware:
- DragonBoard™ 410c with power supply
- Host machine (Linux, Mac OS X, or Windows)
- MicroSD card with 4GB or more of storage
- USB Mouse and/or keyboard
- HDMI Monitor with full size HDMI cable 


***
#### Step 2: Download SD Card Image

- Debian SD Card Image ([Direct Download](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/dragonboard410c_sdcard_install_debian-*.zip) / <a href="http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/" target="_blank">Build Folder</a>)

>Note the location of all downloads, they will be needed once you access your instruction set

***
#### Step 3: Choose your host computer to access your instruction set

- [Linux](https://github.com/96boards/documentation/wiki/DragonBoard™-410c-Linux-Install#linux-host)
- [Mac OS X](https://github.com/96boards/documentation/wiki/DragonBoard™-410c-Linux-Install#mac-os-x-host)
- [Windows](https://github.com/96boards/documentation/wiki/DragonBoard™-410c-Linux-Install#windows-host)

***

[<img src="http://i.imgur.com/znkTVHx.png" data-canonical-src="http://i.imgur.com/znkTVHx.png" width="125" height="300" />]()



***

#### Your Build Choice

[<img src="http://i.imgur.com/7rrS2JR.png" data-canonical-src="http://i.imgur.com/7rrS2JR.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/OQGR5yY.png" data-canonical-src="http://i.imgur.com/OQGR5yY.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/yRQKDI6.png" data-canonical-src="http://i.imgur.com/yRQKDI6.png" width="125" height="157" />]()
[<img src="http://i.imgur.com/tXXN5bZ.png" data-canonical-src="http://i.imgur.com/tXXN5bZ.png" width="125" height="157" />]()

[<<< Back to DragonBoard™ 410c Crossroads](https://github.com/96boards/documentation/wiki/DragonBoard™-410c-Crossroads)

***
#### Step 1: Read about the Fastboot Method

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
#### Step 2: Download Debian Bootloader and Boot file

- Debian Bootloader ([Direct Download](http://builds.96boards.org/releases/dragonboard410c/linaro/rescue/latest/dragonboard410c_bootloader_emmc_linux*.zip) / <a href="http://builds.96boards.org/releases/dragonboard410c/linaro/rescue/latest/" target="_blank">Build Folder</a> )
- Debian Boot ([Direct Download](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/boot-linaro-jessie-qcom-snapdragon-arm64-*.img.gz) / <a href="http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/" target="_blank">Build Folder</a> )

#### Step 3: Download ONE Root File System

- Debian Rootfs (Desktop) ([Direct Download](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/linaro-jessie-alip-qcom-snapdragon-arm64-*.img.gz) / <a href="http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/" target="_blank">Build Folder</a> )
- Debian Rootfs (Command line) ([Direct Download](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/linaro-jessie-developer-qcom-snapdragon-arm64-*.img.gz) / <a href="http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/" target="_blank">Build Folder</a> )

>Note the location of all downloads, they will be needed once you access your instruction set

***
#### Step 3: Choose your host computer to access your instruction set

- [Linux](https://github.com/96boards/documentation/wiki/DragonBoard™-410c-Linux-Install#linux-host-1)
- [Mac OS X](https://github.com/96boards/documentation/wiki/DragonBoard™-410c-Linux-Install#mac-osx-host)

***