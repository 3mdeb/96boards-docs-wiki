# 96Boards HiKey

### Table of Contents

  * [96Boards HiKey](#96boards-hikey)
    * [Getting Started](#getting-started)
      * [Updating to the new Release](#updating-to-the-new-release)
    * [1. New Features](#1-new-features)
    * [2. Pre-Installed Debian Linux](#2-pre-installed-debian-linux)
      * [Power Supply](#power-supply)
      * [Monitor](#monitor)
      * [Powering up the board](#powering-up-the-board)
      * [Wireless Network](#wireless-network)
      * [Wired Network](#wired-network)
      * [Bluetooth](#bluetooth)
      * [Audio Device](#audio-device)
      * [Other Useful Information](#other-useful-information)
    * [3. Installing build of Android Open Source Project](#3-installing-build-of-android-open-source-project)
    * [8. Building Software from Source Code](#8-building-software-from-source-code)
      * [Bootloader From Source](#bootloader-from-source)
      * [Kernel From Source](#kernel-from-source)
      * [WiFi Driver From Source](#wifi-driver-from-source)
      * [Install onto eMMC](#install-onto-emmc)
      * [Install onto SD card](#install-onto-sd-card)
      * [AOSP Build From Source](#aosp-build-from-source)
      * [Appendix 1: Partition Information](#appendix-1-partition-information)

## Getting Started

This document describes how to get started with the HiKey ARMv8 community development boards using the release build shipped with the boards.

**NOTE:** that the June 2015 release comes with a fastboot bootloader based on HiSilicon code. It is deprecated and will not be supported in the upcoming releases. This Getting Started Guide therefore refers to the open source [ARM Trusted Firmware and UEFI bootloader](https://github.com/96boards/documentation/wiki/HiKeyUEFI). It is the supported bootloader for the HiKey board.

**NOTE:** there are two types of eMMC sized HiKey, 4GB vs. 8GB. Those with "LEMAKER" mark in top side and black in color are 8GB ones. Otherwise, they are 4GB.

**NOTE:** there are two types of LPDDR RAM sized HiKey, 1GB vs. 2GB. You can identify them by checking silkmasks on chips: K4E8E304EE-EGCE is 8Gb/1GB, K4E6E304EE-EGCE is 16Gb/2GB.

**The following information is provided in this release notes:**

1. [New Features](#section-0)
2. [Pre-Installed Debian Linux](#section-1)
Information on the Debian 8.0 ("jessie") OS installation software
3. [Installing Android Open Source Project](#section-2)Information on loading the AOSP version of Android 5.1 as an alternative OS onto the HiKey board
4. [Updating the OS](#section-3)
Information on loading an OS update from 96Boards.org
5. [Board Recovery](#section-4)
Information on board recovery and/or loading bootloader software onto the HiKey board
6. [Hardware notes](#section-5)
7. [Known Issues](#section-6)
8. [Building Software from Source Code](#section-7)
Information on building software for the HiKey board from source code
9. [Appendices](#appendix-1)
Information on the partition table used on HiKey and the contents of the boot partition.

### Updating to the new Release

If you already have a HiKey board, you will need to do the following:
- Follow the instructions in [Board Recovery - Installing a Bootloader](#section-41), to update the bootloader on your board
- Follow the instructions in [Updating the OS](#section-3), to install either the Debian or the Android Open Source Project (AOSP) build

<a name="section-0"></a>
## 1. New Features

- [ARM Trusted Firmware and UEFI supported](https://github.com/96boards/documentation/wiki/HiKeyUEFI), with source open. It is recommended to update the bootloader and OS together. <br\>
- MCU firmware updated <br\>
- PSCI features supported: cpuidle, cpufreq, cpu hotplug and suspend/resume 
- Extended support for more HDMI modes, switchable through hotkey 'Alt'+'PrtSc'+'g' 
- New boot sequence: SD card booting first, fallback to eMMC. 
- SD high speed cards (SDR50, SDR104, and DDR50) are supported.
- OpenGL ES 2.0 for Debian
- Video playback on Debian

For getting started guide about [ATF/UEFI, please see WiKi](https://github.com/96boards/documentation/wiki/HiKeyUEFI).

<a name="section-1"></a>
## 2. Pre-Installed Debian Linux 
The HiKey board is ready to use “out of the box” with a preinstalled version of the Debian Linux distribution.

To get started you will need a power supply, an HDMI monitor, a USB keyboard and a mouse.

**IMPORTANT NOTES**

- HDMI EDID display data is used to determine the best display resolution. On monitors and TVs that support 1080p (or 1200p) this resolution will be selected. If 1080p is not supported the next available resolution reported by EDID will be used. This selected mode will work with **MOST but not all** monitors/TVs. See [below for further information](#section-52) on what to do if your monitor/TV does not display the startup console and UI, and a list of monitors/TVs which can/cannot work with HiKey. 
- There are limitations on the usage of the USB ports on the HiKey board. Please refer to the [Hardware section](#section-53) in the document for further information.

### Power Supply

The HiKey board requires an external power supply providing 12V at 2A. (The board will also work with 9V or 15V power supplies). It is not possible to power the board from a USB power supply because we are not designing HiKey that way. Reasons behind that come from many folds: such as the board can use more power than is available from a standard USB power supply, and we supports both USB OTG and USB Host.

The HiKey board uses an EIAJ-3 DC Jack with an outer diameter 4.75mm and a 1.7mm barrel, center pin positive. Please do not use EIAJ-2 plug that has an outer diameter 4.0mm and a 1.7mm barrel which fits to the the EIAJ-3 DC jack but it will have weak ground connection because of smaller diameter and makes the HiKey unstable.
 
### Monitor

A standard monitor or TV supporting at least 640x480 resolution is required. Interlaced operation is not currently supported. The maximum resolutions currently supported are 1920x1080p or 1920x1200p. Information on selecting the resolution is [provided below](#section-52).

### Powering up the board

Link 1-2 causes HiKey to auto-power up when power is applied. The other two links should be not fitted (open). If Link 1-2 is not installed then the back edge push button switch is used to power on the HiKey board. 

Please refer to the Hardware User Guide (Chapter 1. Settings Jumper) for more information on board link options.

A few seconds after applying power the right hand first green User LED will start flashing at a frequency corresponding to cpu's activity. The next User LED is used as a disk indicator showing access to the on-board eMMC flash memory. The startup console messages will then appear on the connected HDMI screen.

After about 10 seconds the LXDE User Interface will appear and you can start using the HiKey Linux software.

### Wireless Network

The HiKey board includes built in [2.4GHz IEEE802.11 b/g/n WiFi networking](http://www.ti.com/product/WL1835MOD). The board does not support the 5GHz band. To use the wireless LAN interface for the first time (or to switch wireless networks) you should click on the wireless LAN icon on the bottom right of the desktop display. The yellow LED between the microUSB and the Type A USB on the front board edge indicates wireless network activity.

You can configure the network from UI, or manually from console:

```
$ sudo nmtui
```

Select 'Activate a connection', Choose your WiFi access point (SSID) and fill the relevant information (password, etc...)

You can check network status by issuing this command.
```
$ sudo nmcli dev wifi
```

### Wired Network

You can connect to a wired network by using a USB Ethernet adapter. Supported adapters should automatically work when the adapter is installed. Please read the [information below](#section-53) on USB port speeds on the HiKey hardware. 

### Bluetooth

The HiKey board includes built-in Bluetooth 4.0 LE support.

To setup a Bluetooth device open the Bluetooth Manager from the Preferences menu. If a “Bluetooth Turned Off” popup appears then select “Enable Bluetooth”. Click on "Search" to search for devices. Try with your bluetooth audio and bluetooth keyboard/mouse. If you make the device trusted then this should operate over a reboot of the board.

The blue LED between the microUSB and the Type A USB on the front board edge indicates bluetooth activity.

### Audio Device

Bluetooth audio devices are supported on HiKey. Follow normal procedures of connecting a bluetooth device to connect to your board.

**NOTE:** HDMI audio is not supported in this release.

Once Bluetooth sound sink is connected, you can open the LXMusic player from the Sound & Video menu. Create a playlist from your music files. Supported audio formats are .mp3 and .ogg. You should now be able to play from the LXMusic player. 

**NOTE:** LXmusic uses xmms2 as the player backend, you may need to install xmms2 and related plugins if they are not installed, otherwise music may cannot be played.
```
$ sudo apt-get install xmms2 xmms2-plugin-*
```

### Other Useful Information

**1. Updating and Adding Software**

Before adding any software to your system you must do an update as follows:
```
$ sudo apt-get update
```
You can now add install software to your system:
```
$ sudo apt-get install [package-name]
```
You can search for available packages: 
```
$ apt-cache search [pattern]
```

**2. File Systems**

HiKey comes with two eMMC size: 4GB and 8GB.

**3. Logging in**

The default user name is "linaro" and the default password for user linaro is also "linaro".

**4. Clock**

The HiKey board does not support a battery powered RTC. System time will be obtained from the network if available. If you are not connecting to a network you will need to manually set the date on each power up or use fake-hwclock:
```
$ sudo apt-get install fake-hwclock
```

<a name="section-15"></a>
**5. USB** 

A utility is provided in /home/linaro/bin to change the configuration of the host (Type A and Expansion) and OTG USB ports. By default these ports operate in low/full speed modes (1.5/12 Mbits/s) to support mouse/keyboard devices. Other USB devices such as network or storage dongles/sticks will be limited to full speed mode. Using the usb_speed utility it is possible to support high speed devices (480 Mbits/s) as long as they are not mixed with full/low speed devices.

For information on using the utility do the following:
```
$ sudo usb_speed -h
```
Please refer to the [Hardware Notes section below](#section-53) for further information on the USB port configuration of the HiKey board.

**6. System and User LEDS**

Each board led has a directory in /sys/class/leds. By default the LEDs use the following triggers:

LED | Trigger
--- | -------
wifi_active | phy0tx (WiFi Tx)
bt_active | hci0tx (Bluetooth Tx)
user_led1 | heartbeat
user_led2 | mmc0 (disk access, eMMC)
user_led3 | mmc1 (disk access, microSD card)
user_led4 | CPU core 0 active(not used)

To change a user LED you can do the following as a root user:
```
# echo heartbeat > /sys/class/leds/<led_dir>/trigger      make a LED flash
# cat /sys/class/leds/<led_dir>/trigger                   show triggers
# echo none > /sys/class/leds/<led_dir>/trigger           remove triggers    
# echo 1 > /sys/class/leds/<led_dir>/brightness           turn LED on
# echo 0 > /sys/class/leds/<led_dir>/brightness           turn LED off
```

<a name="section-2"></a>
## 3. Installing build of Android Open Source Project 

**IMPORTANT NOTE:**
Note that for this release you MUST first update the bootloader using the procedure described in [Board Recovery - Installing a Bootloader](#section-41). If you have not already done this then you will need to do so before proceeding.

Users may install a version of the build of Android Open Source Project (AOSP) onto the HiKey board. This will remove the factory installed Debian Linux OS. This section provides instructions on installing the AOSP build which consists of:
- Derived from Linux 3.18 kernel
- AOSP Android Lollipop (5.x)

Download the following files from:
[https://builds.96boards.org/releases/hikey/linaro/aosp/latest](https://builds.96boards.org/releases/hikey/linaro/aosp/latest)
- boot_fat.uefi.img.tar.xz
- cache.img.tar.xz
- system.img.tar.xz
- userdata-4gb.img.tar.xz (for 4GB board) or userdata-8gb.img.tar.xz (for 8GB board)

Download the following file from:
[https://builds.96boards.org/releases/hikey/linaro/binaries/latest](https://builds.96boards.org/releases/hikey/linaro/binaries/latest)
- [ptable-aosp-4g.img](https://builds.96boards.org/releases/hikey/linaro/binaries/latest/ptable-aosp-4g.img) (for 4GB board) or
- [ptable-aosp-8g.img](https://builds.96boards.org/releases/hikey/linaro/binaries/latest/ptable-aosp-8g.img) (for 8GB board)

Uncompress the .tar.xz files using your operating system file manager, or with the following command for each file:
```
$ tar -Jxf [filename].tar.xz
```
To install updates you will need a Linux PC with fastboot support. For information on installing and setting up UEFI bootloader to HiKey, see [Board Recovery - Installing a Bootloader](#section-41) below.

After setting up fastboot on your Linux PC do the following:

Install Link 5-6 on the HiKey board. This tells the bootloader to start up in fastboot mode.

Name | Link | State
---- | ---- | -----
Auto Power up | Link 1-2 | closed
Boot Select | Link 3-4 | open
GPIO3-1 | Link 5-6 | closed

Power on the HiKey board and verify communications from the Linux PC:

Wait about 10 seconds.

You should see the ID of the HiKey board returned
```
$ sudo fastboot devices
0123456789abcdef fastboot
```

Then install the update using the downloaded files.

For flashing the bootloader, the top two links should be installed (closed) and the 3rd link should be removed (open):

Name | Link | State
---- | ---- | -----
Auto Power up | Link 1-2 | closed
Boot Select | Link 3-4 | closed
GPIO3-1 | Link 5-6 | open

**NOTE:** the ptable must be flashed first. Wait for a few seconds after the reboot command to allow the bootloader to restart using the new partition table. (Example goes with 8G)
```
$ sudo fastboot flash ptable ptable-aosp-8g.img (for 4GB board) (ptable-aosp-4g.img if 8GB board)
$ sudo fastboot reboot
$ sudo fastboot flash boot boot_fat.uefi.img
$ sudo fastboot flash cache cache.img
$ sudo fastboot flash system system.img
$ sudo fastboot flash userdata userdata-8gb.img
```

When flashing is completed power down the HiKey, remove Link 5-6 and power up the HiKey. You may now use the AOSP operating system.  Note the first time boot up will take a couple of minutes. 

Name | Link | State
---- | ---- | -----
Auto Power up | Link 1-2 | closed
Boot Select | Link 3-4 | open
GPIO3-1 | Link 5-6 | open

Please read the Hardware notes and the Known Issues in this document before using the OS.

<a name="section-3"></a>
## 4. Updating the OS 

Updates to 96Boards supported operating systems will be made available at:
[https://builds.96boards.org/releases/hikey](https://builds.96boards.org/releases/hikey)

Developer snapshot updates are also provided at:
[https://builds.96boards.org/snapshots/hikey](https://builds.96boards.org/snapshots/hikey)

Note that these snapshots represent engineering work in progress towards the next release. They may not be functional or stable and are provided as-is without support. 

**IMPORTANT NOTE:**
The installation process will overwrite all contents of the eMMC memory. This will remove all installed software and all user files. Before updating the OS, make sure that you have saved any user files or data that you want to keep onto an SD Card or USB memory stick.
Note that for this release you MUST first update the bootloader using the procedure described in [Board Recovery - Installing a Bootloader](#section-41). If you have not already done this then you will need to do so before proceeding.

To install updates you will need a Linux PC with fastboot support. See [section here](#section-42) about how to do that for your Linux PC.

Once fastboot is installed on the Linux PC proceed as follows:

### Debian Linux OS

Download the following files onto your Linux PC from: 
[https://builds.96boards.org/releases/hikey/linaro/debian/latest](https://builds.96boards.org/releases/hikey/linaro/debian/latest)
- boot-fat.uefi.img.gz
- hikey-jessie_alip_2015MMDD-nnn-4g.emmc.img.gz (for 4GB board) or 
- hikey-jessie_alip_2015MMDD-nnn-8g.emmc.img.gz (for 8GB board)

**NOTE:** _developer version comes with no graphics UI; _alip version comes with LXDE UI.

Download the following file from:
[https://builds.96boards.org/releases/hikey/linaro/binaries/latest](https://builds.96boards.org/releases/hikey/linaro/binaries/latest)
- [ptable-linux-4g.img](https://builds.96boards.org/releases/hikey/linaro/binaries/latest/ptable-linux-4g.img) (for 4GB board)
or
- [ptable-linux-8g.img](https://builds.96boards.org/releases/hikey/linaro/binaries/latest/ptable-linux-8g.img) (for 8GB board)

Note that the Debian image is a large file and may take several minutes (or longer on a slow internet connection) to load. You will need to accept the end user license for the Mali GPU software before you are able to download the OS image. 

Unzip the .gz files (using gunzip or equivalent)

Install Link 5-6 on the HiKey board. This tells the bootloader to start up in fastboot mode. 

Name | Link | State
---- | ---- | -----
Auto Power up | Link 1-2 | closed
Boot Select | Link 3-4 | open
GPIO3-1 | Link 5-6 | closed

Power on the HiKey board and verify communications from the Linux PC:

Wait about 10 seconds.

You should see the ID of the HiKey board returned
```
$ sudo fastboot devices
0123456789abcdef fastboot
```

Then install the update using the downloaded files:

Make sure pin1-pin2 and pin3-pin4 on J15 are linked (recovery mode)

Name | Link | State
---- | ---- | -----
Auto Power up | Link 1-2 | closed
Boot Select | Link 3-4 | closed
GPIO3-1 | Link 5-6 | open

**NOTE:** the ptable must be flashed first. Wait for a few seconds after the reboot command to allow the bootloader to restart using the new partition table. (Example goes with 8G board)
```
$ sudo fastboot flash ptable ptable-linux-8g.img
$ sudo fastboot reboot
$ sudo fastboot flash boot boot-fat.uefi.img
$ sudo fastboot flash system hikey-jessie_alip_2015MMDD-nnn-8g.emmc.img
```
When completed, power down the HiKey, remove Link 3-4 and power up the HiKey. If you wish to use a keyboard and mouse in the Type A USB ports, remember to remove the microUSB cable. 

Name | Link | State
---- | ---- | -----
Auto Power up | Link 1-2 | closed
Boot Select | Link 3-4 | open
GPIO3-1 | Link 5-6 | open

You may now use the updated OS.

**Using an SD Card**

**NOTE:** The UEFI bootloader on HiKey also enables booting a kernel and root file system installed on an SD card (microSD). To control boot order, follow [the instruction here](https://github.com/96boards/documentation/wiki/HiKeyUEFI#section-boot-order). 

This section describes how to prepare a bootable SD card.

Download the following file onto your Linux PC from: 
[https://builds.96boards.org/releases/hikey/linaro/debian/latest](https://builds.96boards.org/releases/hikey/linaro/debian/latest)
  - hikey-jessie_alip_2015MMDD-nnn-4g.img.gz (for 4GB board) or 
  - hikey-jessie_alip_2015MMDD-nnn-8g.img.gz (for 8GB board)

**NOTE:** _developer version comes with no graphics UI; _alip version comes with LXDE UI.

Extract the file. Install an SD card into your Linux PC. Make sure that you know the SD card device node before carrying out the next step.

**NOTE:** Adding the sync flag and others as outlined bellow are very important! Do not skip this option!

```
$ sudo dd if=hikey-jessie_alip_2015MMDD-nnn.img of=/dev/[XXX such as sdb or mmcblk0] bs=4M oflag=sync status=noxfer
```

**NOTE:** Be very careful not to overwrite your hard drive! In most cases, XXX will be mmcblk0 or sdb. This can be found by using the following sequence:

1. Make sure the SD Card is not in the host PC
2. From the host PC terminal command line, run the following command:
```shell
   lsblk
```
3. Note the listed blocks such as sda, sdb, etc.
4. Insert the SD Card into the host PC
5. From the host PC terminal command line, run the following command:
```shell
   lsblk
```
6. There will be a new device in the list, this will be your SD Card
   identity (XXX).  It also has a size parameter that should match the size of the SD Card.

If your SD card capacity is more than 2GB capacity you may want to change the rootfs to use the rest of the SD card as follows:
```
$ sudo apt-get install realpath
$ wget https://github.com/fboudra/resize-helper/raw/master/resize-helper.sh
$ chmod u+x resize-helper.sh
$ sudo ./resize-helper.sh
```

### Android Open Source Project (AOSP)

Instructions about installing AOSP on HiKey are described in [this Section above](#section-2).

<a name="section-4"></a>
## 5. Board Recovery 

<a name="section-41"></a>
### Installing a Bootloader 

For most users a board can be “recovered” from a software failure by reloading the operating system using the instructions provided above. However, if the primary bootloader in the eMMC flash memory has been corrupted then the bootloader will need to be re-installed. This section describes how to reinstall the primary bootloader. 
 
**Preparation**

Download the following files onto a Linux PC:
* [l-loader.bin](https://builds.96boards.org/releases/hikey/linaro/binaries/latest/l-loader.bin)
* [fip.bin](https://builds.96boards.org/releases/hikey/linaro/binaries/latest/fip.bin)
* [ptable-linux-4g.img](https://builds.96boards.org/releases/hikey/linaro/binaries/latest/ptable-linux-4g.img) (if 4GB board) or [ptable-linux-8g.img](https://builds.96boards.org/releases/hikey/linaro/binaries/latest/ptable-linux-8g.img) (if 8GB board) for Debian.
* [ptable-aosp-4g.img](https://builds.96boards.org/releases/hikey/linaro/binaries/latest/ptable-aosp-4g.img) (if 4GB board) or [ptable-aosp-8g.img](https://builds.96boards.org/releases/hikey/linaro/binaries/latest/ptable-aosp-8g.img) (if 8GB board) for AOSP.
* [nvme.img](https://builds.96boards.org/releases/hikey/linaro/binaries/latest/nvme.img)

You will also need the boot partition for the OS Image you want to run
* [boot-fat.uefi.img for Debian] (https://builds.96boards.org/releases/hikey/linaro/debian/latest/boot-fat.uefi.img.gz)
* [boot_fat.uefi.img for AOSP](https://builds.96boards.org/releases/hikey/linaro/aosp/latest/boot_fat.uefi.img.tar.xz)

You can do this from your browser or from the command prompt:
For example, to download the latest UEFI build and boot partition for Debian do:

```shell
$ wget https://builds.96boards.org/releases/hikey/linaro/binaries/latest/l-loader.bin
$ wget https://builds.96boards.org/releases/hikey/linaro/binaries/latest/fip.bin
$ wget https://builds.96boards.org/releases/hikey/linaro/debian/latest/ptable-linux-4g.img
$ wget https://builds.96boards.org/releases/hikey/linaro/debian/latest/ptable-linux-8g.img
$ wget https://builds.96boards.org/releases/hikey/linaro/binaries/latest/nvme.img
$ wget https://builds.96boards.org/releases/hikey/linaro/debian/latest/boot-fat.uefi.img.gz
```

Uncompress the boot image as follows:
```shell
$ gunzip boot-fat.uefi.img.gz
```

You will also need the fastboot application installed on your Linux PC – if this is not installed then follow the instructions [at the end of this section](#section-42). 

Connect a standard microUSB cable between the HiKey microUSB and your Linux PC. Do not power up the HiKey board yet.

**Set Board Link options**

For flashing the bootloader, the top two links should be installed (closed) and the 3rd link should be removed (open):

Name | Link | State
---- | ---- | -----
Auto Power up | Link 1-2 | closed
Boot Select | Link 3-4 | closed
GPIO3-1 | Link 5-6 | open

Link 1-2 causes HiKey to auto-power up when power is installed. Link 3-4 causes the HiKey SoC internal ROM to start up in at a special "install bootloader" mode which will install a supplied bootloader from the microUSB OTG port into RAM, and will present itself to a connected PC as a ttyUSB device.

Please refer to the [Hardware User Guide](https://www.96boards.org/wp-content/uploads/2015/02/HiKey_User_Guide_Rev0.2.pdf) (Chapter 1. Settings Jumper) for more information on the HiKey link options.

Now connect the HiKey power supply to the board.

**NOTE:** USB does NOT power the HiKey board. You must use an external power supply.

**NOTE:** The HiKey board will remain in USB load mode for 90 seconds from power up. If you take longer than 90 seconds to start the install then power cycle the board before trying again.

Wait about 5 seconds and then check that the HiKey board has been recognized by your Linux PC:
```
$ ls /dev/ttyUSB*
or
$ dmesg
```
[hisi-idt.py](https://raw.githubusercontent.com/96boards/burn-boot/master/hisi-idt.py) is the download tool for the HiKey. This is used to install the bootloader as follows:

Execute the following commands as a script or individually:

First, get the script that is needed to load the initial boot software:
```
$ wget https://raw.githubusercontent.com/96boards/burn-boot/master/hisi-idt.py
```
Run the script to initially prepare fastboot (make sure the modem interface is in the right ttyUSB as previously suggested. In this example, use ttyUSB0):
```
$ sudo python hisi-idt.py -d /dev/ttyUSB0 --img1=l-loader.bin
```
After the python command has been issued you should see the following output. If you do not then see the "Problems with Python Downloader" section below
```
+----------------------+
 Serial:  /dev/ttyUSB0
 Image1:  l-loader.bin
 Image2:  
+----------------------+

Sending l-loader.bin ...
Done
```
**NOTE:** You may see the word “failed” before Done. This is under investigation but is not fatal. As long as the “Done” is printed at the end you may proceed.

The bootloader has now been installed into RAM. Wait a few seconds for the fastboot application to actually load. The following fastboot commands then load the partition table, the bootloader and other necessary files into the HiKey eMMC flash memory (4GB or 8GB). Taking 8GB as example.

**NOTE:** the ptable must be flashed first. Wait for a few seconds after the reboot command to allow the bootloader to restart using the new partition table. (Example goes with 8G)


```
$ sudo fastboot flash ptable ptable-linux-8g.img (if 8GB board) (ptable-linux-4g.img for 4GB board)
$ sudo fastboot reboot
$ sudo fastboot flash fastboot fip.bin
$ sudo fastboot flash nvme nvme.img
$ sudo fastboot flash boot boot-fat.uefi.img
```

Once this has been completed the bootloader has been installed into eMMC.
Power off the HiKey board by removing the power supply jack.

Next change the link configuration as follows:

Name | Link | State
---- | ---- | -----
Auto Power up | Link 1-2 | closed
Boot Select | Link 3-4 | open
GPIO3-1 | Link 5-6 | closed

Now connect power supply jack to your HiKey again.

Check that the HiKey board is detected by your Linux PC

Wait about 10 seconds.

You should see the ID of the HiKey board returned
```
$ sudo fastboot devices
0123456789abcdef fastboot
```

Your bootloader has been successfully installed and you are now ready to install the operating system system files into the eMMC flash memory (see [Updating the OS](#section-3), above). For Debian you will need to load only the system partition, and for AOSP the cache, system and user data partitions. 

**NOTE:**

This bootloader is based on UEFI and includes:
- ARM Trusted Firmware
- UEFI with DeviceTree
- GRUB
- fastboot support
- OP-TEE support

For further information on the bootloader, including how to build it from source, see the 96Boards documentation here:
- [HiKey Bootloader Wiki](https://github.com/96boards/documentation/wiki/HiKeyUEFI)

<a name="section-42"></a>
**Installing Fastboot onto your PC**

Step 1: Use the following commands
```
$ sudo apt-get install android-tools-fastboot      On Debian/Ubuntu
$ sudo yum install android-tools                   On Fedora
```

Step 2: Either create the file: /etc/udev/rules.d/51-android.rules with the following content, or append the content to the file if it already exists. You will need to have superuser privileges so use
```
$ sudo vim /etc/udev/rules.d/51-android.rules       or 
$ sudo gedit /etc/udev/rules.d/51-android.rules
```
 to create and edit the file.  Add the following to the file.

```
# fastboot protocol on HiKey
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="d00d", MODE="0660", GROUP="dialout"
# adb protocol on HiKey
SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", ATTR{idProduct}=="1057", MODE="0660", GROUP="dialout"
# rndis for HiKey
SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", ATTR{idProduct}=="1050", MODE="0660", GROUP="dialout" 
```

**Problems with Python Downloader**<br\>

The Python download script requires Python 2. Make sure you're not defaulted to Python 3 by typing:
```
$ python --version
```

**NOTE:** Python 3 currently has a serial library bug, and will fail during data transfer - so if you are using Python 3 then you will need to install and/or change to Python 2.7:
```
$ sudo apt-get install python2.7 python2.7-dev
$ alias python=python2.7
```

If you get the following error message while running the hisi-idt.py script:
```
ImportError: No module named serial
```
Then you need to install the python-serial module, on Ubuntu/Debian run:
```
$ sudo apt-get install python-serial
```
or you can use pip install:
```
$ sudo pip install pyserial
```
If you have Python 3 installed, make sure to install with the right version, for instance:
```
$ sudo pip2.7 install pyserial
```

<a name="section-7"></a>
## 8. Building Software from Source Code 

THIS SECTION NEEDS REVIEW AND UPDATE FOR NEW RELEASE
DO NOT USE THESE INSTRUCTIONS 
UPDATE FOR NEW KERNEL, WIFI MODULE AND BOOTLOADER

### Bootloader From Source

For further information on the bootloader building from source, see the 96Boards documentation here:
- [HiKey Bootloader Wiki](https://github.com/96boards/documentation/wiki/HiKeyUEFI)

### Kernel From Source

To build a kernel using a linux computer use the following instructions. These assume that you have a good level of knowledge in using Linaro tools and building Linux kernels.

The HiKey kernel sources are located at: [https://github.com/96boards/linux](https://github.com/96boards/linux)

To build a kernel, make sure you have an AArch64 cross-toolchain installed on your linux computer, and configured to cross compile to ARMv8 code. For example, Linaro GCC 4.9:
```
$ wget https://releases.linaro.org/14.09/components/toolchain/binaries/\
gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux.tar.xz
$ mkdir ~/arm64-tc
$ tar --strip-components=1 -C ~/arm64-tc -xf gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux.tar.xz
$ export PATH=~/arm64-tc/bin:$PATH
```

**NOTE:** the toolchain binaries are for a 32 bit host system. On Debian/Ubuntu, you should install multiarch-support and enabled i386 architecture. On Fedora, you should install glibc.i686 package.

The following instructions can then be used to build the kernel:

Visit the release page which kernel image would you like to build from source,
and take notes the location of the git repository and the branch or tag used for the build.

For the Landing Team releases: <br>
&nbsp;  http://builds.96boards.org/releases/hikey/linaro/debian/ <br>
For the Reference Platform Build releases: <br>
&nbsp;  http://builds.96boards.org/releases/reference-platform/debian/hikey/

Git clone the source code tree:
```
$ git clone /location/of/repository (such as, https://github.com/96boards/linux.git or https://github.com/rsalveti/linux.git)
$ cd linux
```
Checkout the branch or the tag which matches the build based on the information on the release page. <br>
For the Landing Team releases: <br>
```
$ git checkout -b working-hikey /name/of/tag (such as, 96boards-hikey-15.11 or 96boards-hikey-15.06)
```
or <br>
For the Reference Platform Build releases: <br>
```
$ git checkout /name/of/branch (such as, reference-hikey-rebase)
```

To build the kernel:
```
$ export ARCH=arm64
$ export CROSS_COMPILE=aarch64-linux-gnu-
$ export LOCALVERSION="-linaro-hikey"

$ make distclean 
$ make defconfig 
$ make -j8 Image modules hi6220-hikey.dtb 2>&1 | tee build-log.txt
```

For the kernel modules:
```
$ export PWD=`pwd`
$ export INSTALL_MOD_PATH="$PWD/installed-modules"

$ mkdir $INSTALL_MOD_PATH
$ make -j8 modules_install
```

If you encounter any error during the build, refer the log in 'build-log.txt'.

### WiFi Driver From Source

The rootfs included in each HiKey release uses a different wifi driver than the one defined in the kernel.config file present in the release page.
https://builds.96boards.org/releases/hikey/linaro/debian/latest

Latest Debian release build is published [here](https://builds.96boards.org/releases/hikey/linaro/debian/latest).

By default, HiKey includes TI R8.5 wl18 driver.

In order to compile and install this driver you will have to do the following:

```
$ git clone https://github.com/96boards/linux linux.git
$ cd linux.git
$ git clone https://github.com/96boards/wilink8-wlan_build-utilites.git build_utilities.git
$ git clone -b hikey https://github.com/96boards/wilink8-wlan_wl18xx.git build_utilities.git/src/driver
$ git clone -b R8.5  https://github.com/96boards/wilink8-wlan_wl18xx_fw.git build_utilities.git/src/fw_download
$ git clone -b hikey https://github.com/96boards/wilink8-wlan_backports.git build_utilities.git/src/backports
$ patch -p1 < build_utilities.git/patches/hikey_patches/0001-defconfig-hikey-discard-CFG80211-and-MAC80211.patch
```

Then compile the kernel as usual. 
Before building the kernel drivers, create a file build_utilities.git/setup-env using the build_utilities.git/setup-env.sample as reference.

Please ignore any warnings/errors reported during the following steps

```
$ cd linux.git
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8 modules INSTALL_MOD_PATH=./build_utilities.git/fs modules_install
$ cd build_utilities.git
$ ./build_wl18xx.sh modules
$ ./build_wl18xx.sh firmware
```

Now, all the kernel drivers and kernel firmwares have been installed in build_utilities.git/fs/lib.

Make sure to remove the following file: lib/firmware/ti-connectivity/wl18xx-conf.bin to avoid the possibility of a format mismatch (the new firmware wl18xx-fw-4.bin uses its internal conf data)

You could now chown root:root the directory, compress it and decompress it in your final target (or an intermediate rootfs if you are generating an image)

```
$ cd build_utilities.git/fs/lib
$ rm firmware/ti-connectivity/wl18xx-conf.bin
$ sudo chown -R root:root *
$ sudo tar jcvf fw-modules.tar.bz2 * 
```

To include the drivers compiled above in a jessie image you would:

a) In your browser, visit [http://repo.linaro.org/ubuntu/linaro-staging/pool/main/a/android-tools/](http://repo.linaro.org/ubuntu/linaro-staging/pool/main/a/android-tools/), find the package name of android-tools-fsutils_`<version>`_amd64.deb, then download with wget and install simg2img and make_ext4fs. Eg:

```
$ wget https://repo.linaro.org/ubuntu/linaro-overlay/pool/main/a/android-tools/android-tools-fsutils_<version>_amd64.deb
$ sudo dpkg -i --force-all android-tools-fsutils_*.deb
```

b) then do the following 

```
$ gzip -d -c hikey-jessie_developer_2015MMDD-nnn.img.gz > /tmp/jessie.img
$ simg2img /tmp/jessie.img /tmp/raw.img
$ mkdir /tmp/mnt
$ sudo mount /tmp/raw.img /tmp/mnt
$ cd /tmp/mnt/lib/
$ sudo tar xvf fw-modules.tar.bz2
$ cd /tmp/
$ sudo make_ext4fs -o -L rootfs -l 2G -s jessie.updated.img mnt/ 
$ sudo umount mnt/
```

**NOTE:** by rebuilding the image file you could also transfer your public ssh keys or private files - like wifi credentials - to the target before booting it.

At this point you would have an image with the required drivers. Now You will need to decide whether you want your kernel to install on internal eMMC, or on an installed microSD card.

### Install onto eMMC

To build the boot image for eMMC:

**Method 1 - Build from scratch**

Create a dummy ramdisk for the ramdisk image:
```
$ touch initrd ; echo initrd | cpio -ov > initrd.img
```

Create the boot image (KERN=Image, DTB=hi6220-hikey.dtb, RAMDISK=initrd.img)
```
$  mkdir boot-fat
$  dd if=/dev/zero of=boot-fat.uefi.img bs=512 count=131072
$  sudo mkfs.fat -F32 -n "boot" out/boot-fat.uefi.img
$  sudo mount -o loop,rw,sync boot-fat.uefi.img boot-fat
$  sudo cp -a $KERN $DTB $RAMDISK boot-fat/ || true
$  sudo mkdir -p boot-fat/EFI/BOOT
$  sudo cp -a AndroidFastbootApp.efi boot-fat/EFI/BOOT/fastboot.efi || true
$  sudo cp -a grubaa64.efi boot-fat/EFI/BOOT/grubaa64.efi || true
$  sudo cp -a grub.cfg boot-fat/EFI/BOOT/grub.cfg || true
$  sudo umount boot-fat
$  sudo rm -rf boot-fat
```

After the above, you can flash the boot-fat.uefi.img to eMMC with the command:
```
$ sudo fastboot flash boot boot-fat.uefi.img
$ sudo fastboot reboot
```

**Method 2 - Use an existing boot-fat.uefi.img**
```
$ mkdir tmp
$ sudo mount boot-fat.uefi.img tmp
$ sudo cp YOUR-KERNEL-BUILD/arch/arm64/boot/Image tmp/Image
$ sudo cp YOUR-KERNEL-BUILD/arch/arm64/boot/dts/hi6220-hikey.dtb tmp/
$ sudo umount tmp
$ rm -rf tmp
```

After the above, you can flash the boot-fat.uefi.img to eMMC with the command:
```
$ sudo fastboot flash boot boot-fat.uefi.img
$ sudo fastboot reboot
```

**NOTE:** if you make ANY of your own changes to the tagged tree your built kernel will be named X.XX.X-linaro-hikey+ (use `uname -a` to see the kernel name). This means that the installed kernel modules in /lib/modules will not work correctly unless you install a new set of kernel modules in /lib/modules from your kernel build.

### Install onto SD card

1. Use the kernel Image and hi6220-hikey.dtb as explained above.
2. Prepare your SD card. See [Using an SD Card]() for more information. There will be two partitions on it: `boot` and `rootfs`
3. Insert your SD card into your Linux PC and copy your newly built kernel and device tree blob onto the SD card boot partition - use your own SD card /dev device in place of /dev/[sda1 sda2]:
```
$ sudo cp -a arch/arm64/boot/Image arch/arm64/boot/dts/hi6220-hikey.dtb /dev/sda1/boot/
$ sudo cp -ar installed-modules/lib/modules/X.X.X-linaro-hikey/ /dev/sda2/lib/modules/ 
```

**NOTE:** File names must not be changed - Refer to [Appendix 1](#appendix-1) to see the 4 files that are expected to be in the boot partition. If any of these are missing from the SD card boot partition, HiKey won't boot successfully. User need to select booting from eMMC by manual instead at this time.

**The boot priority of SD card is higher than boot priority of eMMC by default. But user could change the priority. Details are illustrated in "Boot Sequence" in HiKey UEFI wiki.**

**NOTE:** if you make ANY of your own changes to the tagged tree your built kernel will be named X.XX.X-linaro-hikey+ (use `uname -a` to see the kernel name). This means that the installed kernel modules in /lib/modules will not work correctly unless you install a new set of kernel modules in /lib/modules from your kernel build.

Plug your SD card to HiKey board.

**Source for jessie rootfs build**

We pull most of the packages from Debian official repository. The remaining changes are available in github at [https://github.com/96boards](https://github.com/96boards)

### AOSP Build From Source

Use the following commands to download, build, and run Android on a HiKey board.

#### Compiling userspace

##### Step 1: Download the Android source tree

```shell
$ repo init -u https://android.googlesource.com/platform/manifest -b master

$ repo sync -j24
```
##### Step 2: Download and extract HDMI binaries into the Android source tree

$ wget https://dl.google.com/dl/android/aosp/linaro-hikey-20160226-67c37b1a.tgz

$ tar xzf linaro-hikey-20160226-67c37b1a.tgz

$ ./extract-linaro-hikey.sh

##### Step 3: Install mcopy utility

```shell
$ apt-get install tools
```

##### Step 4: Build

```shell
$ . ./build/envsetup.sh

$ lunch hikey-userdebug

$ make -j32
```

> ***Note:*** Note: For 4GB eMMC, instead of `$ make -j32` use: `$ make -j32 TARGET_USERDATAIMAGE_4GB=true`.

***

#### Installing initial fastboot and ptable

##### Step 1: Select special bootloader mode by linking J15 1-2 and 3-4 pins (for details, refer to the <a href="https://www.96boards.org/wp-content/uploads/2015/02/HiKey_User_Guide_Rev0.2.pdf" target="_blank">HiKey User Guide</a>).

##### Step 2: Connect USB to PC to get ttyUSB device (ex: /dev/ttyUSB1).

##### Step 3: Power the board

```shell
$ cd device/linaro/hikey/installer

$ ./flash-all.sh /dev/ttyUSB1 [4g]
```

##### Step 4: Remove jumper 3-4 and power the board

***

#### Flashing images

##### Step 1: Enter fastboot mode by linking J15 1-2 and 5-6 pins

##### Step 2: Run the following commands

```shell
$ fastboot flash boot out/target/product/hikey/boot_fat.uefi.img

$ fastboot flash -w system out/target/product/hikey/system.img
```

##### Step 3: Remove jumper 5-6 and power the board.

***

#### Building the kernel

##### Step 1: Run the following commands

```shell
$ git clone https://android.googlesource.com/kernel/hikey-linaro

$ cd hikey-linaro

$ git checkout -b android-hikey-linaro-4.1 origin/android-hikey-linaro-4.1

$ make ARCH=arm64 hikey_defconfig

$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- -j24
```

##### Step 2: Copy output to the hikey kernel directory (/kernel/hikey-linaro)

- Copy hi6220-hikey.dtb (`arch/arm64/boot/dts/hisilicon/hi6220-hikey.dtb`) to the hikey-kernel directory.
- Copy the Image directory (`arch/arm64/boot/Image`) to the hikey-kernel directory.

***

#### Setting monitor resolution

Edit `device/linaro/hikey/bootloader/EFI/BOOT/grub.cfg` and configure the video setting. Example setting for a 24" monitor: `video=HDMI-A-1:1280x800@60`.

***

#### Configuring kernel serial output (uart3)

Set the J2 low speed expansion connector to 1 - Gnd, 11 - Rx, 13 - Tx . For details, refer to the (<a href="https://www.96boards.org/wp-content/uploads/2015/02/HiKey_User_Guide_Rev0.2.pdf" target="_blank">HiKey User Guide</a>).

**End of AOSP Build from Source**

***