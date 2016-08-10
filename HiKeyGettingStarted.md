# 96Boards HiKey

## Getting Started

This section has moved [here](https://github.com/96boards/documentation/blob/master/ConsumerEdition/HiKey/README.md)

### Updating to the new Release

This section has moved [here](https://github.com/96boards/documentation/blob/master/ConsumerEdition/HiKey/Quickstart/README.md#updating-to-a-new-release-or-change-your-operating-system)

## 1. New Features

This section has moved [here](http://builds.96boards.org/releases/hikey/linaro/debian/latest/#tabs-1)

For getting started guide about [ATF/UEFI, please see WiKi](https://github.com/96boards/documentation/wiki/HiKeyUEFI).

### Power Supply

This section has moved [here](https://github.com/96boards/documentation/blob/master/ConsumerEdition/HiKey/Quickstart/PowerAdapter.md)
 
### Monitor

This section has moved [here](https://github.com/96boards/documentation/blob/master/ConsumerEdition/HiKey/Quickstart/MonitorHDMI.md)

### Powering up the board

This section has moved [here](https://github.com/96boards/documentation/blob/master/ConsumerEdition/HiKey/Quickstart/README.md#starting-the-board-for-the-first-time)

### Wireless Network

This section has moved [here](https://github.com/96boards/documentation/blob/master/ConsumerEdition/HiKey/Configuration/WirelessTIModule.md)

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

**Clock**

This section has moved [here](https://github.com/96boards/documentation/blob/master/ConsumerEdition/HiKey/Configuration/Clock.md)

**USB** 

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

## Installing build of Android Open Source Project 

This section has moved [here](https://github.com/96boards/documentation/blob/master/ConsumerEdition/HiKey/Downloads/AOSP.md)

### Debian Linux OS

This section has moved [here](https://github.com/96boards/documentation/blob/master/ConsumerEdition/HiKey/Downloads/Debian.md)

## Board Recovery 

This section has moved [here](https://github.com/96boards/documentation/blob/master/ConsumerEdition/HiKey/Installation/BoardRecovery.md)

## Building Software from Source Code 

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

This section has moved [here](https://source.android.com/source/devices.html)