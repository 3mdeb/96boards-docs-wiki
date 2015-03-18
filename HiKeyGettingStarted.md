**96Boards HiKey**

**Getting Started**

This document describes how to get started with the Early Access HiKey ARMv8 community development board. 

PLEASE READ THIS

**These release notes apply to Early Access HiKey boards that are being provided to Linaro developers and other community developers prior to general availability of the HiKey board (which is expected to be end March 2015). While the hardware is functional, the current software described in this document is pre-release and still under active development. Please understand that this is a work in progress and that things will change. This software is NOT yet functionally complete.**

**Before powering up the HiKey board please read these notes.**

**The startup procedure for the Early Access boards involves flashing the internal eMMC with an updated bootloader and the operating system. **

**Note that after the Early Access program, boards will be shipped with the bootloader and OS pre-installed so the HiKey will work "out of the box".  Developers will still be able to then update the bootloader if they wish. **

**The following is provided in this release:**

1. Files and procedure to prepare the Early Access HiKey board shipped from the factory for pre-release Debian 8.0 ("Jessie") OS installation.

Note that this is only required for Early Access boards. For production, images will be pre-flashed onto the HiKey board. 

2. A Linux 3.18-based kernel with a pre-release version of Debian 8.0 ("Jessie") for ARMv8

## Getting Started

You will need the following to get started:

**Software**

* The following software package that you can find on 96Boards website:

[https://builds.96boards.org/releases/hikey](https://builds.96boards.org/releases/hikey)

* ptable.img
* fastboot1.img
* fastboot2.img
* nvme.img
* mcuimage.bin

* Images for the pre-release Debian 8.0 ("Jessie") file system 

[https://builds.96boards.org/releases/hikey/debian](https://builds.96boards.org/releases/hikey/debian)

* eMMC system image for the HiKey flash storage (required)
  * boot-fat.emmc.img.gz	(FAT format boot image, with cmdline rootfs pointing to eMMC)
  * hikey-jessie_developer_20150208-104.emmc.img.gz 
* SD card image for booting to SD card (optional)
  * boot-fat.img.gz	(FAT format boot image, with cmdline rootfs pointing to SD card)
  * hikey-jessie_developer_20150208-104.img.gz

* The fastboot application installed on your Linux PC – if this is not installed use the following commands

* On Debian/Ubuntu
    $ sudo apt-get install android-tools-fastboot
* On Fedora
    $ sudo yum install android-tools

Either create the file: /etc/udev/rules.d/51-android.rules with the following content, or append the content to the file if it already exists:

    # fastboot protocol on Kirin620 SoC
    SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="d00d", MODE="0660", GROUP="dialout"
    # adb protocol on Kirin620 SoC
    SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", ATTR{idProduct}=="1057", MODE="0660", GROUP="dialout"
    # rndis for Kirin620 SoC
    SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", ATTR{idProduct}=="1050", MODE="0660", GROUP="dialout" 

**Hardware**

* An Early Access HiKey board
* A Linux computer
* A nominal 12V power supply (8-18V) with 2A or more of current capacity – the HiKey board connector uses a 1.7mm pin. An Adapter is provided to also enable you to also use power supplies with a 2.1mm pin. The pin is the positive connection.
* A standard microUSB cable connected between the HiKey microUSB port and your Linux PC
* A microSD card with at least 2GB capacity (optional)
* A USB keyboard
* An HDMI monitor
  * IMPORTANT NOTE:  For the Early Access software HDMI EDID display data is not used. A fixed HDMI timing is used at 1280x720p 60Hz which may not work with all monitors/TVs

**HiKey Board Hardware User Guide**

* [https://www.96boards.org/hikey-userguide](https://www.96boards.org/hikey-userguide)

**Board pin options**

Please refer to the Hardware User Guide (Chapter 1. Settings Jumper) for more information.

For the flashing the bootloader (fastboot), the top two links ("AUTO PWR" [1-2] and "BOOT SEL" [3-4]) should initially be closed and the 3rd link (GPIO3 1 [5-6]) should be open.

Link 1-2 causes HiKey to auto-power up when power is installed. Link 3-4 causes HiKey bootROM to stop at a special "install bootloader" mode which will install a supplied bootloader from the microUSB OTG port into RAM.

## Loading the Software - Pre-release Debian 8.0 ("Jessie")

**1. Prepare the HiKey board**

Connect a standard microUSB to USB connector between the HiKey microUSB port and your Linux PC.
Connect the HiKey power supply to the board.

**Note:** USB does NOT power the HiKey board because the power supply requirements in certain use cases can exceed the power supply available on a USB port. You must use an external power supply.

**2. Loading the Software Build**

With Links 1-2 and 3-4 on, check that the HiKey board has been recognized by your Linux PC 

    $ ls /dev/ttyUSB*

The following instructions assume that /dev/ttyUSB0 is the tty port for communication with the HiKey board.

[hisi-idt.py](https://raw.githubusercontent.com/96boards/burn-boot/master/hisi-idt.py) is the Python download tool for the HiKey. 
This is used to install the bootloader as follows:

Execute the following commands as a script or individually:

First, get the Python script to write fastboot into the bootROM:

    wget https://raw.githubusercontent.com/96boards/burn-boot/master/hisi-idt.py

The script was written for Python 2. Make sure you're not default to Python 3 by typing:

    python --version

Run the script to initially prepare fastboot:

    sudo python hisi-idt.py -d /dev/ttyUSB0 --img1 fastboot1.img --img2 fastboot2.img

If you get the following error message, while running the hisi-idt.py script:

    ImportError: No module named serial

Then you need to install the python-serial module, on Ubuntu/Debian, simply run:

    sudo apt-get install python-serial

If not, you can use pip install:

    sudo pip install pyserial

If you have Python 3 installed, make sure to install with the right version, for instance:

    sudo pip2.7 install pyserial

After the python command has been issued you should see the following output:

    +----------------------+
     Serial:  /dev/ttyUSB0
     Image1:  fastboot1.img
     Image2:  fastboot2.img
    +----------------------+

    Sending fastboot1.img ...
    Done

    Sending fastboot2.img ...
    Done

This means that the bootloader has been successfully installed into RAM. Wait at least 10 seconds for fastboot to actually load. The following fastboot commands then load the partition table, the bootloaders and other necessary files into the HiKey eMMC flash memory. 

    sudo fastboot flash ptable ptable.img
    sudo fastboot flash fastboot1 fastboot1.img
    sudo fastboot flash fastboot fastboot2.img
    sudo fastboot flash nvme nvme.img
    sudo fastboot flash mcuimage mcuimage.bin
    sudo fastboot reboot

Once this has been completed the bootloader has been installed into eMMC. 

Power off the HiKey board by removing the power supply jack.

Next change the link configuration as follows:

1. remove the 2nd jumper ("BOOT SEL" [3-4]) so that the HiKey board will boot from the newly installed bootloader in eMMC. 
2. Install the 3rd jumper ("GPIO3 1" [5-6]) so that the HiKey board will enter fastboot mode when powered up
(if the link is open HiKey will try to boot an OS that is not yet installed).

Now power up the HiKey board again.

Check that the HiKey board is detected by your Linux PC:

You should see the ID of the HiKey board returned

    sudo fastboot devices

0123456789abcdef fastboot

Now you are ready to install the operating system into the eMMC flash memory.[1] 

    sudo fastboot flash boot boot-fat.emmc.img
    sudo fastboot flash system hikey-jessie_developer_20150208-104.emmc.img

Once you have completed these operations you should be able to boot the HiKey board from eMMC:

* Power down the board by removing the power supply cable
* Remove jumper "GPIO3 1" [5-6] to allow the HiKey board to boot normally
* Remove the microUSB cable to enable the Type A USB host ports*
* Ensure that an HDMI monitor is attached and powered on
* Ensure that an USB keyboard is attached to one of the Type A USB host ports
* Ensure that there is no SD card installed
* Reinsert the power supply cable

*Alternatively you may attach a keyboard directly to the micro USB port if you have a suitable OTG cable. 

The board should boot into the pre-release Debian 8.0 ("jessie") distribution. After about 1 minute you should see the console login appear on the HDMI display. 

[1] If you don't have access to the serial port you might want to modify the filesystem image to configure the WIFI connectivity before flashing it (see WIFI configuration instructions in section four of this document)

To modify the emmc sparse image do the following:

    $ sudo apt-get install android-tools-fsutils
    $ simg2img hikey-jessie_developer_20150208-104.emmc.img raw.img
    $ sudo mount raw.img <mount point>

You can now edit the file system from your host machine:

    $ sudo cp wlan0 <mount point>/etc/network/interfaces.d/
    $ sudo mkdir <mount point>/root/.ssh/
    $ sudo cp my_id_rsa.pub <mount point>/root/.ssh/authorized_keys

 once done:

    $ sudo make_ext4fs -L rootfs -l 1500M -s hikey-jessie_developer_20150208-104.updated.emmc.img <mount point>
    $ sudo umount <mount point>

**3. Using a SD Card**

The eMMC boot software enables an alternative boot method to a boot kernel and root file system installed on an SD card. If an SD card is installed at power up the HiKey board will boot to the SD Card software rather than the built-in eMMC.

This section describes how to prepare a bootable SD card.

Using your Linux PC copy the SD card image onto the SD card. 

**Important note:** presently SD and SDHC cards are supported. SDXC and UHS cards are not yet supported by the HiKey software. 

Install an SD card into your PC. Make sure that you know the SD Card device node before carrying out the next step. **Note:** for this example we assume the device node is /dev/sdb. Replace with your assigned SD card device.

    $ sudo dd if=hikey-jessie_developer_20150208-104.img of=/dev/[sdb] bs=4M oflag=sync status=noxfer

Plug off/in SD card, then flash the boot partition:

    # fastboot flash boot boot-fat.img

If your SD Card is more than 2GB capacity you may want to change the rootfs to use the rest of the SD Card as follows:

    $ sudo fdisk /dev/sdb

* use p to list partitions
* note the start cylinder number of rootfs
* use d to delete the root partition info
* use n to create the new primary partition (the start cylinder must be same as before)
* use w to write the partition table (don’t worry about error message)
* remove the disk and re-insert

    $ sudo resize2fs /dev/sdb2 

will make the file system take up all the space left on the SD Card.

**4. Configuration Information**

**Clock**

The HiKey board does not support a battery powered RTC and NIST has not yet been implemented to update the system time from the network. Therefore remember to set the date on each power up.

**Ethernet**

A standard USB to Ethernet dongle may be used to get network connectivity. You will need to manually add the configuration to /etc/network/interfaces.d/eth0 for it to come up, and link /etc/resolv.conf (see Known Issues below).

**WiFi**

WiFi is coming soon to the HiKey build. The following information will apply once WiFi is supported:

To configure networking on a WPA protected WiFi network carry out the following steps:

Create a wpa_supplicant configuration file for your WiFi network:

Do the following on your Linux PC:

Restrict the permissions of /etc/network/interfaces, to prevent pre-shared key (PSK) disclosure:

    # chmod 0600 /etc/network/interfaces

Generate a WPA PSK hash for your SSID:

    $ wpa_passphrase myssid my_very_secret_passphrase
    network={
      ssid="myssid"
      #psk="my_very_secret_passphrase"
      psk=ccb290fd4fe6b22935cbae31449e050edd02ad44627b16ce0151668f5f53c01b
    }

Now on the HiKey board edit /etc/network/interfaces

    $ sudo vi /etc/network/interfaces

Define appropriate stanzas for your wireless interface, along with the SSID and PSK HASH. 
For example using the psk from the previous step:

    auto wlan0
    iface wlan0 inet dhcp
        wpa-driver nl80211
        wpa-ssid myssid
        wpa-psk ccb290fd4fe6b22935cbae31449e050edd02ad44627b16ce0151668f5f53c01b

Bring your interface up. This will start wpa_supplicant as a background process.

    $ sudo ifup wlan0

The network should now be running and can be verified by using for example:

    $ ping www.google.com

**Bluetooth**

To verify basic Bluetooth operation you can carry out the following commands.

    # hciconfig hci0 up
    # hcitool scan

## Hardware Notes

**Schematics**

* [https://www.96boards.org/hikey-schematics](https://www.96boards.org/hikey-schematics)

**CPU Load**

The supplied Linux 3.18-based kernel supports the thermal protection framework and DVFS. 

This will cause the HiKey core frequencies to be reduced from the maximum 1.2GHz if the thermal setpoint of the SoC is reached. In an extreme case thermal shutoff will occur if DVFS has not been effective at reducing the SoC temperature to an acceptable level. 

Higher performance may be obtained by using forced air (fan) cooling on the HiKey board. 

**HDMI Port**

Note that hotplug of the HDMI monitor is not yet supported. The monitor must be attached and power up before powering on the HiKey board.

**USB Ports**

There are multiple USB ports on the HiKey board:

1x microUSB OTG port on the front panel
2x Type A USB 2.0 host ports on the front panel
1x Type A USB 2.0 host ports on the high-speed expansion bus

Please read the HiKey Board Hardware User Guide for more information on the following hardware restrictions:

1. The microUSB OTG port may be used (in host or slave mode) OR the Type A host ports may be used. They may **not** both be used **simultaneously**.
2. For the OTG board Low Speed (1.5Mbit/sec), Full Speed (12Mbit/sec) or High Speed (480Mbit/sec) devices are supported. 
3. For the USB host ports all attached USB devices MUST be the same speed - either Low Speed (1.5Mbit/sec), Full Speed (12Mbit/sec) or High Speed (480Mbit/sec). If devices with different speeds are attached the devices will not operate correctly. This also applies if any hubs are attached to the ports. The reason for this limitation is that USB split transfers are not supported by the mobile-targeted SoC hardware USB implementation.

See the notes below for additional temporary software restrictions on USB usage. This text will be removed when the software has been updated. 

## Software Notes / Known Issues

1. Framebuffer console is not yet operational at power up.
2. USB Ports - the USB Host ports currently only support Low and Full Speed devices. 
Note the hardware restrictions on mixing device speeds, above. In future it will be possible for the user to switch the USB host ports to High speed device support. 
3. ~~Bluetooth operation is currently limited to a 115Kbit/sec rate. In future it will be possible to operate at higher Bluetooth speeds.~~
4. WiFi operation is not yet supported. 
5. Audio (Bluetooth and HDMI audio) is not yet supported. 
6. Graphics acceleration (Mali 450) is not yet supported. 
7. HDMI EDID support is not yet available. Some monitors may not operate with the pre-installed HDMI output setting at 1280x720p 60Hz.
8. When running dhclient for the first time on the HiKey board, a warning is displayed:

*Warning: /etc/resolv.conf is not a symbolic link to /etc/resolvconf/run/resolv.conf*

A workaround is available: create the symlink using the following command:

    # ln -s /etc/resolvconf/run/resolv.conf /etc/resolv.conf

## Building the Kernel

To build a kernel using a linux computer use the following instructions. These assume that you have a good level of knowledge in using Linaro tools and building Linux kernels.

The HiKey kernel sources are located at: [https://github.com/96boards/linux.git](https://github.com/96boards/linux.git)

To build a kernel, make sure you have an Aarch64 cross-toolchain installed on your linux computer, and configured to cross compile to ARMv8 code. For example, Linaro GCC 4.9:

    $ wget http://releases.linaro.org/14.09/components/toolchain/binaries/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux.tar.xz
    $ mkdir ~/arm64-tc/bin
    $ tar --strip-components=1 -C ~/arm64-tc/bin -xf gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux.tar.xz
    $ export PATH=~/arm64-tc/bin:$PATH

Note: the toolchain binaries are for 32bit host system. On Debian/Ubuntu, you should install multiarch-support and enabled i386 architecture. On Fedora, you should install glibc.i686 package.

The following instructions can then be used to build the kernel:

Git clone the source code tree:

    $ git clone https://github.com/96boards/linux.git

To build the kernel:

    # make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
    # make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j`getconf _NPROCESSORS_ONLN` Image modules dtbs

To build the boot image:

**Note:** 

* Replace the root device as appropriate. 
For eMMC, use root=/dev/mmcblk0p7
For microSD, use root=/dev/mmcblk1p2

For the ramdisk image, use the image from the pre-release Debian 8.0 ("Jessie") or create a dummy ramdisk: 

    $ touch initrd ; echo initrd | cpio -v > ramdisk.img

* Make sure to respect the naming scheme

Creating the boot image:

    $ echo "console=tty0 console=ttyAMA0,115200n8 root=/dev/mmcblk0p7 rootwait rw" > cmdline
    $ mkdir boot-fat
    $ dd if=/dev/zero of=boot-fat.img bs=512 count=131072
    $ sudo mkfs.fat -n "BOOT IMG" boot-fat.img
    $ sudo mount -o loop,rw,sync boot-fat.img boot-fat
    $ sudo cp -a arch/arm64/boot/Image boot-fat/Image
    $ sudo cp arch/arm64/boot/dts/hi6220-hikey.dtb boot-fat/lcb.dtb
    $ sudo cp initrd.img boot-fat/ramdisk.img
    $ sudo mv cmdline boot-fat/cmdline
    $ sudo umount boot-fat
    $ rm -rf boot-fat

After the above, you can flash the boot-fat.img to eMMC with the command:

    $ sudo fastboot flash boot boot-fat.img
    $ sudo fastboot reboot

**Install onto SD Card**

1. Use the kernel Image and hi6220-hikey.dtb as explained above.
2. Prepare your SD card. There will be two partitions on it: boot and rootfs
3. Insert your SD card into your Linux PC and copy your newly built kernel onto the SD card boot partition. 

Note: File names are important. 
Refer to Table 2 to find out all four files that expected to be in the boot partition. In case any of these missing from SD's boot partition, it will fall back to eMMC boot partition and boot from eMMC.

4. Plug your SD card to Hikey board.

**Source for jessie rootfs build**

We pull all the packages from Debian official repository. 
The only change is uim package. 
Sources are available in github at [https://github.com/96boards](https://github.com/96boards)

## Appendix 1 Partition Information

Table 1 describes the partition layout info on HiKey eMMC

<table>
  <tr>
    <td>Name</td>
    <td>Partition</td>
    <td>Offset</td>
    <td>Size</td>
  </tr>
  <tr>
    <td>fastboot1</td>
    <td>1</td>
    <td>0x0000_0000</td>
    <td>0x0004_0000 (256KB)</td>
  </tr>
  <tr>
    <td>ptable</td>
    <td>0</td>
    <td>0x0000_0000</td>
    <td>0x0010_0000 (1MB)</td>
  </tr>
  <tr>
    <td>vrl</td>
    <td>0</td>
    <td>0x0010_0000</td>
    <td>0x0010_0000 (1MB)</td>
  </tr>
  <tr>
    <td>vrl_backup</td>
    <td>0</td>
    <td>0x0020_0000</td>
    <td>0x0010_0000 (1MB)</td>
  </tr>
  <tr>
    <td>mcuimage</td>
    <td>0</td>
    <td>0x0030_0000</td>
    <td>0x0010_0000 (1MB)</td>
  </tr>
  <tr>
    <td>fastboot</td>
    <td>0</td>
    <td>0x0040_0000</td>
    <td>0x0080_0000 (8MB)</td>
  </tr>
  <tr>
    <td>nvme</td>
    <td>0</td>
    <td>0x00C0_0000</td>
    <td>0x0020_0000 (2MB)</td>
  </tr>
  <tr>
    <td>boot</td>
    <td>0</td>
    <td>0x00E0_0000</td>
    <td>0x0400_0000 (64MB)</td>
  </tr>
  <tr>
    <td>Reserved</td>
    <td>0</td>
    <td>0x04E0_0000</td>
    <td>0x1000_0000 (256MB)</td>
  </tr>
  <tr>
    <td>cache</td>
    <td>0</td>
    <td>0x14E0_0000</td>
    <td>0x1000_0000 (256MB)</td>
  </tr>
  <tr>
    <td>system</td>
    <td>0</td>
    <td>0x24E0_0000</td>
    <td>0x6000_0000 (1536MB)</td>
  </tr>
  <tr>
    <td>userdata</td>
    <td>0</td>
    <td>0x84E0_0000</td>
    <td>0x6000_0000 (1536MB)</td>
  </tr>
</table>

Table 1: HiKey Partitions

Table 2 describes the binaries located in the boot partition

<table>
  <tr>
    <td>File Name</td>
    <td>Description</td>
    <td>Supported Max. Size</td>
  </tr>
  <tr>
    <td>Image</td>
    <td>Kernel Image</td>
    <td>16MB</td>
  </tr>
  <tr>
    <td>ramdisk.img</td>
    <td>Ramdisk Image</td>
    <td>8MB</td>
  </tr>
  <tr>
    <td>lcb.dtb</td>
    <td>Device Tree Binary</td>
    <td>512KB</td>
  </tr>
  <tr>
    <td>cmdline</td>
    <td>Command line text file</td>
    <td>512B</td>
  </tr>
</table>

Table 2: boot partition files