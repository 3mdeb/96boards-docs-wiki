[<<< Back to HiKey Home](https://github.com/96boards/documentation/wiki/HiKey-Home)

***

### Getting started with HiKey ARMv8 community development board

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