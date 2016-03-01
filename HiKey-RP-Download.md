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

> Note: Some files have 4G and 8G options, download file which best matches your HiKey board.

Build Folders (<a href="http://builds.96boards.org/releases/hikey/linaro/binaries/latest/" target="_blank">**Binaries**</a> / <a href="http://builds.96boards.org/releases/hikey/linaro/aosp/latest/" target="_blank">**Image**</a>)

- **l-loader.bin** ([**Download**](http://builds.96boards.org/releases/hikey/linaro/binaries/latest/l-loader.bin))
- **fip.bin** ([**Download**](http://builds.96boards.org/releases/hikey/linaro/binaries/latest/fip.bin))
- **nvme.img** ([**Download**](http://builds.96boards.org/releases/hikey/linaro/binaries/latest/nvme.img))
- **ptable-aosp.img** ([**4G Download**](http://builds.96boards.org/releases/hikey/linaro/binaries/latest/ptable-aosp-4g.img) / [**8G Download**](http://builds.96boards.org/releases/hikey/linaro/binaries/latest/ptable-aosp-8g.img))
- **hisi-idt.py** ([**Download**](http://builds.96boards.org/releases/hikey/linaro/binaries/latest/hisi-idt.py))
- **boot_fat.uefi.img** ([**Download**](http://builds.96boards.org/releases/hikey/linaro/aosp/latest/boot_fat.uefi.img.tar.xz))
- **cache.img.tar.xz** ([**Download**](http://builds.96boards.org/releases/hikey/linaro/aosp/latest/cache.img.tar.xz))
- **userdata.img.xz** ([**4G Download**](http://builds.96boards.org/releases/hikey/linaro/aosp/latest/userdata-4gb.img.tar.xz) / [**8G Download**](http://builds.96boards.org/releases/hikey/linaro/aosp/latest/userdata-8gb.img.tar.xz))
- **system.img.tar.xz** (<a href="http://builds.96boards.org/releases/hikey/linaro/aosp/latest/system.img.tar.xz" target="_blank">**Download**</a>)

***

#### Step 3: Choose your host computer to access your instruction set

- [Linux](https://github.com/96boards/documentation/wiki/HiKey-Android-Install#linux-host)


***