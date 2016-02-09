[<<< Back to DragonBoard™ 410c Home](https://github.com/96boards/documentation/wiki/Dragonboard-410c)
# Dragonboard™ 410c Linux Installation Guide


This Users Guide provides a general overview for getting started with Linux installations on the [DragonBoard™ 410c](https://www.96boards.org/products/ce/dragonboard410c/). 

There are two primary ways to install software onto the DragonBoard™ 410c:
- SD Card
- Fastboot

**Making your way through this document is easy!**

1. Read about both installation methods
2. Choose your method
3. Choose your host machine (This is the machine you will be using throughout the process)
4. Follow your custom set of steps

If you are having trouble with this document please <a href="https://youtu.be/EGLHbs5ZDRQ" target="_blank">click here</a> for a video walkthrough.



***


#### Step 1: Read about both installation methods

## SD Card Method
The SD card method allows you to place a microSD card into the DragonBoard™ 410c to automatically boot and install the Linux Desktop onto the board. This method is generally simpler and should be used by beginners. 

This method requires the following hardware:
- DragonBoard™ 410c with power supply
- Host machine (Linux, Mac OS X, or Windows)
- MicroSD card with 4GB or more of storage
- USB Mouse and/or keyboard
- HDMI Monitor with full size HDMI cable

Skip to the [Install Debian Using SD Card](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#install-debian-using-sd-card) section to use this method.   

## Fastboot Method
Fastboot is supported by the board and can be used for installs.  This is for advanced users who are most likely modifying/customizing source code and will need to download such updates to the board for test/execution. When installing Debian using Fastboot, you will have the option to install either the Developer(console-only) image, or the LXDE(Desktop) image.  

> **Note:** When installing Debian using the SD Card method, LXDE(Desktop) install is currently the only option,  Fastboot is the only way to attain a Console-only Debian install.

This method requires the following hardware:
- DragonBoard™ 410c with power supply
- Host machine (Linux, Mac OS X, or Windows)
- USB to microUSB cable
- USB Mouse and/or keyboard (not required to perform flash)
- HDMI Monitor with full size HDMI cable (not required to perform flash)

Skip to the [Install Debian Using Fastboot](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#install-debian-using-fastboot) to use this method.

***

#### Step 2: Choose your Method

**Choose your Installation Method:**

- [**Install Debian using SD Card**](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#install-debian-using-sd-card)
- [**Install Debian Using Fastboot**](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#install-debian-using-fastboot)


***


# Install Debian using SD Card
[Back to Step 2](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#step-2-choose-your-method)

#### Step 3: Choose your Host Machine

- [**Linux Host**](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#linux-host)
- [**Mac OSX Host**](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#mac-osx-host)
- [**Windows Host**](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#windows-host)


***


## Linux Host

- [Getting Started](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#getting-started)
- [Install Image onto SD Card](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#install-image-onto-sd-card)
- [Flashing SD Card Image to the DragonBoard™ 410c](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flashing-sd-card-image-to-the-dragonboard-410c)



This section is intended for users who would like to use the SD Card Method for Linux installation with their Linux host machine.

Please watch this [optional video tutorial]() (COMING SOON - 02/13/16) if you are having trouble following the document.

### Getting Started

This section builds the SD Card image for the DragonBoard™ 410c. The steps in this section are executed entirely from the host PC. It is assumed that the developer is using a Linux development host.

**Step 1**: Prepare MicroSD card

Make sure you have backed up all valuable data from SD card. Everything on SD card, prior to flashing Linux image, will be lost by the end of this procedure.

**Step 2**: [Download Debian SD Card Install Image](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/dragonboard410c_sdcard_install_debian*.zip)

**Step 3**: Unzip the downloaded install file

> Note the directory the install image was extracted to, as this will be required in the next step. There are multiple tools to unzip and extract these archives.

Your SD card and install file should be ready! In the next section we will flash your install file onto your SD card.

### Install Image onto SD Card

> Note: SD card does not need to be formatted in any special way since this procedure will write the entire image, including the partition table.

**From the command prompt on the host PC, enter the following sequence of commands:**

```shell
# cd to the directory the install file was extracted to
$ cd <extraction directory>

$ sudo dd if=db410c_sd_install_debian-YY.img of=/dev/XXX bs=4M oflag=sync status=noxfer
```

**Warning:** Executing the sync flag command as outlined above is very
important! Do not skip this step!

**Warning:** Be very careful not to overwrite your hard drive! In most
cases, XXX will be mmcblk0 or sdb.

> **YY** is Debian release number of downloaded file
**XXX** is the SD card device name ([Click here for instructions on how to find microSD card device name](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#instructions-on-how-to-find-microsd-card-devices-name-in-linux-xxx))

**Flashing your SD card could take several minutes. Please be patient. When SD card is done flashing, eject device and move to the next section.**

### Flashing SD Card Image to the DragonBoard™ 410c

Once the image is written on the SD Card per the previous section,
perform the following steps to flash the image into the eMMC memory on
the DragonBoard™ 410c:

- Make sure DragonBoard™ 410c is unplugged
- Insert the microSD card into the DragonBoard™ 410c
- Set the S6 switch on the DragonBoard™ 410c to: `0-1-0-0` {SD Boot switch set to “ON”}
- Plug a USB keyboard and/or mouse into either of the two USB
  connectors on the DragonBoard™ 410c
  
>Note: If no mouse is used, the keys in the parenthesis on the
installer screen can be used to initiate install commands. For
example “Install(i)” would be the “i” key on the keyboard. Arrow
keys may also be used during the command initiation sequences.

- Connect an HDMI monitor to the DragonBoard™ 410c with an HDMI cable, and power
  on the monitor
- Connect the power cable to the DragonBoard™ 410c

When the board powers up, it will boot into an installer similar to the
figure below:

<img src="http://i.imgur.com/F18wlgU.png" data-canonical-src="http://i.imgur.com/F18wlgU.png" width="400" height="250"/>

- Select the image to install and then click on “Install” (or type
  “i”) and the OS will be installed into the eMMC memory on the
  DragonBoard™ 410c.

After installation completes, a “Flashing has completed and OS has
installed successfully....” message will appear on the HDMI monitor
connected to the DragonBoard™ 410c.

- Remove the SD Card and click “OK” as instructed, and the DB410c will
  reboot into the newly installed OS

Upon completion of the above, the user will now see a Debian Desktop (Login screen)

**Congratulations! You are now booting your newly installed OS directly
from eMMC on the DragonBoard™ 410c!**


***


## Mac OSX Host

- [Getting Started](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#getting-started-1)
- [Install Image onto SD Card](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#install-image-onto-sd-card-1)
- [Flashing SD Card Image to the DragonBoard™ 410c](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flashing-sd-card-image-to-the-dragonboard-410c-1)

This section is intended for users who would like to use the SD Card Method for Linux installation with their Mac OS X host machine.

Please watch this [optional video tutorial]() (COMING SOON - 02/13/16) if you are having trouble following the document.

### Getting Started

This section builds the SD Card image for the DragonBoard™ 410c. The steps in this section are executed entirely from the host PC. It is assumed that the developer is using a MAC OS X development host.

**Step 1**: Prepare MicroSD card

Make sure you have backed up all valuable data from SD card. Everything on SD card prior to installing image will be lost by the end of this procedure.

**Step 2**: [Download Debian SD Card Install Image](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/dragonboard410c_sdcard_install_debian*.zip)

**Step 3**: Unzip the downloaded install file

> Note the directory the install image was extracted to, as this will be required in the next step. There are multiple tools to unzip and extract these archives. **In most cases MAC OS X will unzip file on its on and leave it in your Downloads folder**.

Your SD card and install file should be ready! In the next section we will flash your install file onto your SD card.

### Install Image onto SD Card

> Note: SD card does not need to be formatted in any special way since this procedure will write the entire image, including the partition table.

**From the terminal on the Mac OS X host machine(press command+space and type in "terminal" to access terminal), enter the following sequence of commands:**

```shell
# cd to the directory the install file was extracted to
$ cd <extraction directory>

$ sudo dd if=db410c_sd_install_debian-YY.img of=/dev/XXX bs=4m
$ sudo sync
```

**NOTE:** Executing the sync flag command as outlined above is very
important! Do not skip this step!

**Warning:** Be very careful not to overwrite your hard drive! In most
cases, XXX will be disk1, disk2, etc...

> **YY** is Debian release number of downloaded file
**XXX** is the SD card device name ([Click here for instructions on how to find microSD card device name](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#instructions-on-how-to-find-microsd-card-devices-name-in-mac-os-x-xxx))

**Flashing your SD card could take several minutes. Please be patient. When SD card is done flashing, eject device and move to the next section.**

### Flashing SD Card Image to the DragonBoard™ 410c

Once the image is written on the SD Card per the previous section,
perform the following steps to flash the image into the eMMC memory on
the DragonBoard™ 410c:

- Make sure DragonBoard™ 410c is unplugged
- Insert the microSD card into the DragonBoard™ 410c
- Set the S6 switch on the DragonBoard™ 410c to: `0-1-0-0` {SD Boot switch set to “ON”}
- Plug a USB keyboard and/or mouse into either of the two USB
  connectors on the DragonBoard™ 410c
  
>Note: If no mouse is used, the keys in the parenthesis on the
installer screen can be used to initiate install commands. For
example “Install(i)” would be the “i” key on the keyboard. Arrow
keys may also be used during the command initiation sequences.

- Connect an HDMI monitor to the DragonBoard™ 410c with an HDMI cable, and power
  on the monitor
- Connect the power cable to the DragonBoard™ 410c

When the board powers up, it will boot into an installer similar to the
figure below:

<img src="http://i.imgur.com/F18wlgU.png" data-canonical-src="http://i.imgur.com/F18wlgU.png" width="400" height="250"/>

- Select the image to install and then click on “Install” (or type
  “i”) and the OS will be installed into the eMMC memory on the
  DragonBoard™ 410c.

After installation completes, a “Flashing has completed and OS has
installed successfully....” message will appear on the HDMI monitor
connected to the DragonBoard™ 410c.

- Remove the SD Card and click “OK” as instructed, and the DB410c will
  reboot into the newly installed OS

Upon completion of the above, the user will now see a Debian Desktop (Login screen)

**Congratulations! You are now booting your newly installed OS directly
from eMMC on the DragonBoard™ 410c!**


***



## Windows Host

- [Getting Started](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#getting-started-2)
- [Install Image using SD Card](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#install-image-onto-sd-card-2)
- [Flashing SD Card Image to the DragonBoard™ 410c](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flashing-sd-card-image-to-the-dragonboard-410c-2)

This section is intended for users who would like to use the SD Card Method for Linux installation with their Windows host machine.

Please watch this [optional video tutorial]() (COMING SOON - 02/13/16) if you are having trouble following the document.

### Getting Started

This section builds the SD Card image for the DragonBoard™ 410c. The steps in this section are executed entirely from the host PC. It is assumed that the developer is using a Windows development host.

**Step 1**: Prepare MicroSD card

Make sure you have backed up all valuable data from SD card. Everything on SD card prior to installing image will be lost by the end of this procedure.

**Step 2**: [Download Debian SD Card Install Image](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/dragonboard410c_sdcard_install_debian*.zip)

**Step 3**: Unzip the downloaded install file

> Note the directory the install image was extracted to, as this will be required in the next step. There are multiple tools to unzip and extract these archives. **In most cases MAC OS X will unzip file on its on and leave it in your Downloads folder**.

**Step 4**: Download the [Win32DiskImager tool](http://sourceforge.net/projects/win32diskimager/)

Your SD card, install file, and necessary tools(Win32DiskImager tool) should be ready! In the next section we will flash your install file onto your SD card.


## Install Image onto SD Card

1. Open the tool, and click the folder icon (top right). Find your way to the appropriate img (This is why you need to remember the location of your extracted image.)

<img src="http://i.imgur.com/cqk6LhL.png" data-canonical-src="http://i.imgur.com/cqk6LhL.png" width="300" height="150"/>

2. Insert your microSD card (through a USB SD card-reader, if necessary).

3. Be sure you have the correct device selected and click "write." **There may be a warning about corrupting the device. Click "Yes" to proceed.**

**Upon completion you should see the following pop-up:**

<img src="http://i.imgur.com/HzYujlw.png" data-canonical-src="http://i.imgur.com/HzYujlw.png" width="150" height="100"/>

**Flashing your SD card could take several minutes. Please be patient. When SD card is done flashing, eject device and move to the next section.**

### Flashing SD Card Image to the DragonBoard™ 410c

Once the image is written on the SD Card per the previous section,
perform the following steps to flash the image into the eMMC memory on
the DragonBoard™ 410c:

- Make sure DragonBoard™ 410c is unplugged
- Insert the microSD card into the DragonBoard™ 410c
- Set the S6 switch on the DragonBoard™ 410c to: `0-1-0-0` {SD Boot switch set to “ON”}
- Plug a USB keyboard and/or mouse into either of the two USB
  connectors on the DragonBoard™ 410c
  
>Note: If no mouse is used, the keys in the parenthesis on the
installer screen can be used to initiate install commands. For
example “Install(i)” would be the “i” key on the keyboard. Arrow
keys may also be used during the command initiation sequences.

- Connect an HDMI monitor to the DragonBoard™ 410c with an HDMI cable, and power
  on the monitor
- Connect the power cable to the DragonBoard™ 410c

When the board powers up, it will boot into an installer similar to the
figure below:

<img src="http://i.imgur.com/F18wlgU.png" data-canonical-src="http://i.imgur.com/F18wlgU.png" width="400" height="250"/>

- Select the image to install and then click on “Install” (or type
  “i”) and the OS will be installed into the eMMC memory on the
  DragonBoard™ 410c.

After installation completes, a “Flashing has completed and OS has
installed successfully....” message will appear on the HDMI monitor
connected to the DragonBoard™ 410c.

- Remove the SD Card and click “OK” as instructed, and the DB410c will
  reboot into the newly installed OS

Upon completion of the above, the user will now see a Debian Desktop (Login screen)

**Congratulations! You are now booting your newly installed OS directly
from eMMC on the DragonBoard™ 410c!**


***


# Install Debian Using Fastboot
[Back to Step 2](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#step-2-choose-your-method)

#### Step 3: Choose your Host Machine

- [**Linux Host**](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#linux-host-1)
- [**Mac OSX Host**](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#mac-osx-host-1)
- [**Windows Host**](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#windows-host-1)


***


##Linux Host

- [Getting Started](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#getting-started-3)
- [Flash Bootloader into on-board eMMC](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flash-bootloader-into-on-board-emmc)
- [Flash Linaro/Debian Release](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flash-linarodebian-release)

### Getting Started

This section will explain the fastboot method for installation of the Linux images onto
the DragonBoard™ 410c. 

Please watch this [optional video tutorial]() (COMING SOON - 02/13/16) if you are having trouble following the document.

**This is for advanced users that plan to be flashing many versions of the OS into the DragonBoard™ 410c.**

**Prerequisites:**

**Before we can start flashing the appropriate files onto you DragonBoard™ 410c**:

- You will need to acquire the appropriate tools (ADB and Fastboot).
- You will need to know how to boot the DragonBoard™ 410c up into fastboot mode. 
- You will need to download all files necessary for install.

**Since the bootloader on this board supports fastboot. The developer should only have to focus on getting fastboot installed on his/her host PC.**

The following steps will walk you through the download and installation of Fastboot onto your host MAC OS X machine:

**Step 1**: Download latest version of the adb-fastboot-install file <a href="https://code.google.com/archive/p/adb-fastboot-install/downloads" target="_blank">here</a>

Clicking the link above will download the appropriate file into your "Downloads" folder.


**Step 2**: Open your terminal by pressing Command+Space and typing in Terminal. Execute the following commands:

```shell
# cd to the directory the ADB and Fastboot file were extracted to, this will most likely be your Downloads folder

$ cd <extraction directory>
$ cd Android
$ ./ADB-Install-Linux.sh

# This command will require root permission, enter your password
```
You have now moved both ADB and Fastboot to your `/usr/bin`, this will allow them utilized from anywhere in your terminal.

Simply type `fastboot` or `adb` from your terminal command line to make sure everything is working properly.

**Step 3**: Now that we are set up we will need to connect our host machine to our DragonBoard™ 410c and boot into Fastboot mode.

**Connect your host machine to your DragonBoard™ 410c using a USB to microUSB cable and follow these instructions:

- Micro SD Card slot on DragonBoard™ 410c must be empty
- S6 switch on the DragonBoard™ 410c must be set to: `0-0-0-0` {All switches in off position}
- Press and hold the Vol (-) button on the DragonBoard™ 410c {S4}, DragonBoard™ 410c should not be powered on yet
- While pressing S4 button, power up the DragonBoard™ 410c by plugging it in
- Release your hold on S4 button within a few seconds of powering on. Board should boot into Fastboot mode.

From the connected host machine terminal window, run the following commands:

```shell
# Check to make sure fastboot device connected.
$ fastboot devices
```

**At this point you should be connected to your DragonBoard™ 410c with a USB to microUSB cable. Your DragonBoard™ 410c should be booted into Fastboot mode and ready to be flashed with the appropriate images.**


***


### Flash Bootloader into on-board eMMC

In this section we will continue by downloading and flashing the bootloader onto your DragonBoard™ 410c. This will be achieved by accessing and executing a script located in the bootloader download folder.

**Step 1**: Download

[Bootloader zip](http://builds.96boards.org/releases/dragonboard410c/linaro/rescue/latest/dragonboard410c_bootloader_emmc_linux-40.zip)

**Step 2**: Flash Bootloader

Open up terminal and execute the following commands:

```shell
# cd to the directory the bootloader zip file was extracted
cd <extraction directory>

sudo ./flashall
```
The bootloader is now installed on the DragonBoard™ 410c!

***

### Flash Linaro/Debian Release

In this section we will flash all remaining parts of the operating system. In order to do this we will be using the fastboot commands that are now readily available to us in our Terminal command line.

**Step 1**: Download `boot` and `rootfs`

- You will need the [**latest Debian boot image**](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/boot-linaro-jessie-qcom-snapdragon-arm64*.img.gz)
- You must choose either the [**Developer**](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/linaro-jessie-developer-qcom-snapdragon-arm64*.img.gz)  **or**  [**ALIP - Desktop**](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/linaro-jessie-alip-qcom-snapdragon-arm64*.img.gz) for your root file system (rootfs).

**The way you experience this operating system will be based on which rootfs you choose for your board.**
Once downloaded, their names should be similar to what you see here:

**Debian boot image:**
`boot-linaro-jessie-qcom-snapdragon-arm64-BUILD#.img.gz`

**Developer rootfs:**
`linaro-jessie-developer-qcom-snapdragon-arm64-BUILD#.img.gz`

**or**

**ALIP-Desktop rootfs:**
`linaro-jessie-alip-qcom-snapdragon-arm64-BUILD#.img.gz`


Where BUILD# is the date/Build stamp for the downloaded file

**Step 2**: Flash 'boot' and 'rootfs' to DragonBoard™ 410c

Flash the boot image and rootfs to the DragonBoard™ 410c by executing the following commands from the host PC:

```shell
# Check to make sure fastboot device connected.  If not resolve
$ sudo fastboot devices

# cd to the directory the boot image and RootFS were extracted
$ cd <extraction directory>

# Make sure you have properly unzipped the boot and rootfs downloads
sudo fastboot flash boot boot-linaro-jessie-qcom-snapdragon-arm64-**BUILD#**.img
sudo fastboot flash rootfs linaro-jessie-developer-qcom-snapdragon-arm64-**BUILD#**.img
```
**Note**: Replace **BUILD#** in the above commands with the file-specific date/build stamp.

Now reboot the DragonBoard™ 410c using the following sequence and it will boot to the command prompt:

- Unplug the power to the DragonBoard™ 410c
- Unplug the micro USB fastboot cable
- Make sure you are plugged in to a HDMI monitor, keyboard and/or mouse depending on your rootfs
- Plug the power back into the DragonBoard™ 410c

**Note:** the **username** and **password** are both **“linaro”** when the login information is requested.

Enjoy your new operating system!

## Mac OSX Host

- [Getting Started](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#getting-started-4)
- [Flash Bootloader into on-board eMMC](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flash-bootloader-into-on-board-emmc-1)
- [Flash Linaro/Debian Release](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flash-linarodebian-release-1)

### Getting Started

This section will explain the fastboot method for installation of the Linux images onto
the DragonBoard™ 410c.  

Please watch this [optional video tutorial]()(COMING SOON - 02/13/16) if you are having trouble following the document.

**This is for advanced users that plan to be flashing many versions of the OS into the DragonBoard™ 410c.**

**Prerequisites:**

**Before we can start flashing the appropriate files onto you DragonBoard™ 410c**:

- You will need to acquire the appropriate tools (ADB and Fastboot).
- You will need to know how to boot the DragonBoard™ 410c up into fastboot mode. 
- You will need to download all files necessary for install.

**Since the bootloader on this board supports fastboot. The developer should only have to focus on getting fastboot installed on his/her host PC.**

The following steps will walk you through the download and installation of Fastboot onto your host MAC OS X machine:

**Step 1**: Download latest version of the adb-fastboot-install file <a href="https://code.google.com/archive/p/adb-fastboot-install/downloads" target="_blank">here</a>

Clicking the link above will download the appropriate file into your "Downloads" folder.


**Step 2**: Open your terminal by pressing Command+Space and typing in Terminal. Execute the following commands:

```shell
# cd to the directory the ADB and Fastboot file were extracted to, this will most likely be your Downloads folder

$ cd <extraction directory>
$ cd Android
$ ./ADB-Install-Mac.sh

# This command will require root permission, enter your password
```
You have now moved both ADB and Fastboot to your `/usr/bin`, this will allow them utilized from anywhere in your terminal.

Simply type `fastboot` or `adb` from your terminal command line to make sure everything is working properly.

**Step 3**: Now that we are set up we will need to connect our host machine to our DragonBoard™ 410c and boot into Fastboot mode.

**Connect your host machine to your DragonBoard™ 410c using a USB to microUSB cable and follow these instructions:

- Micro SD Card slot on DragonBoard™ 410c must be empty
- S6 switch on the DragonBoard™ 410c must be set to: `0-0-0-0` {All switches in off position}
- Press and hold the Vol (-) button on the DragonBoard™ 410c {S4}, DragonBoard™ 410c should not be plugged in yet
- While pressing S4 button, power up the DragonBoard™ 410c.
- Release your hold on S4 button within a few seconds of powering on. Board should boot into Fastboot mode.

From the connected host machine terminal window, run the following commands:

```shell
# Check to make sure fastboot device connected.
$ sudo fastboot devices
```
>Note: if you are experiencing trouble bringing your DragonBoard™ 410c into fastboot mode, the original boot loader could be corrupted. In this case you will need to fix this by following one of the two procedures found below:

  - [Create / Install a Rescue Image]()
  - [Installing Image using an SD Card Image]()


**At this point you should be connected to your DragonBoard™ 410c with a USB to microUSB cable. Your DragonBoard™ 410c should be booted into Fastboot mode and ready to be flashed with the appropriate images.**


***


### Flash Bootloader into on-board eMMC

In this section we will continue by downloading and flashing the bootloader onto your DragonBoard™ 410c. This will be achieved by accessing and executing a script located in the bootloader download folder.

**Step 1**: Download

[Bootloader zip](http://builds.96boards.org/releases/dragonboard410c/linaro/rescue/latest/dragonboard410c_bootloader_emmc_linux-40.zip)

**Step 2**: Flash Bootloader

Open up terminal and execute the following commands:

```shell
# cd to the directory the bootloader zip file was extracted
cd <extraction directory>

sudo ./flashall
```
The bootloader is now installed on the DragonBoard™ 410c!

***

### Flash Linaro/Debian Release

In this section we will flash all remaining parts of the operating system. In order to do this we will be using the fastboot commands that are now readily available to us in our Terminal command line.

**Step 1**: Download `boot` and `rootfs`

- You will need the [**latest Debian boot image**](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/boot-linaro-jessie-qcom-snapdragon-arm64*.img.gz)
- You must choose either the [**Developer**](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/linaro-jessie-developer-qcom-snapdragon-arm64*.img.gz)  **or**  [**ALIP - Desktop**](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/linaro-jessie-alip-qcom-snapdragon-arm64*.img.gz) for your root file system (rootfs).

**The way you experience this operating system will be based on which rootfs you choose for your board.**
Once downloaded, their names should be similar to what you see here:

**Debian boot image:**
`boot-linaro-jessie-qcom-snapdragon-arm64-BUILD#.img.gz`

**Developer rootfs:**
`linaro-jessie-developer-qcom-snapdragon-arm64-BUILD#.img.gz`

**or**

**ALIP-Desktop rootfs:**
`linaro-jessie-alip-qcom-snapdragon-arm64-BUILD#.img.gz`


Where BUILD# is the date/Build stamp for the downloaded file

**Step 2**: Flash 'boot' and 'rootfs' to DragonBoard™ 410c

Flash the boot image and rootfs to the DragonBoard™ 410c by executing the following commands from the host PC:

```shell
# Check to make sure fastboot device connected.  If not resolve
$ sudo fastboot devices

# cd to the directory the boot image and RootFS were extracted
$ cd <extraction directory>

# Make sure you have properly unzipped the boot and rootfs downloads
sudo fastboot flash boot boot-linaro-jessie-qcom-snapdragon-arm64-**BUILD#**.img
sudo fastboot flash rootfs linaro-jessie-developer-qcom-snapdragon-arm64-**BUILD#**.img
```
**Note**: Replace **BUILD#** in the above commands with the file-specific date/build stamp.

Now reboot the DragonBoard™ 410c using the following sequence and it will boot to the command prompt:

- Unplug the power to the DragonBoard™ 410c
- Unplug the micro USB fastboot cable
- Make sure you are plugged in to a HDMI monitor, keyboard and/or mouse depending on your rootfs
- Plug the power back into the DragonBoard™ 410c

**Note:** the **username** and **password** are both **“linaro”** when the login information is requested.

Enjoy your new operating system!

***

## Windows Host (COMING SOON - 02/11/16)

- [Getting Started](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#getting-started-5)
- [Flash Bootloader into on-board eMMC](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flash-bootloader-into-on-board-emmc-2)
- [Flash Linaro/Debian Release](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flash-linarodebian-release-2)

### Getting Started

This section will explain the fastboot method for installation of the Linux images onto
the DragonBoard™ 410c. 

Please watch this [optional video tutorial]()(COMING SOON - 02/13/16) if you are having trouble following the document.

### Flash Bootloader into on-board eMMC

### Flash Linaro/Debian Release




#End of Document

***


## Instructions on how to find microSD card devices name in Linux (XXX)

**Step 1**: Access command prompt (make sure SD card is **NOT** inserted into host PC)

**Step 2**: Run the following command

Code:

```shell    
$ df -aTh
```

Sample print out:
 
```shell   
    linaro-alip@linaro:~>$ df -aTh               
    rootfs           rootfs                  20G     19G  131M  100% /
    devtmpfs         devtmpfs               1,9G    8,0K  1,9G    1% /dev
    /dev/sda13       ext4                    20G     19G  131M  100% /
    sysfs            sysfs                     0       0     0     - /sys
    tmpfs            tmpfs                  1,9G       0  1,9G    0% /sys/fs/cgroup
    securityfs       securityfs                0       0     0     - /sys/kernel/security
    debugfs          debugfs                   0       0     0     - /sys/kernel/debug
    /dev/sda14       ext4                   384G     72G  311G   19% /home
    linaro-alip@linaro:~>$
```

**Step 3**: Insert SD card and run command again

Code:

```shell    
$ df -aTh
```

Sample print out:
   
```shell 
linaro-alip@linaro:~>$ df -aTh               
rootfs           rootfs                  20G     19G  131M  100% /
devtmpfs         devtmpfs               1,9G    8,0K  1,9G    1% /dev
/dev/sda13       ext4                    20G     19G  131M  100% /
sysfs            sysfs                     0       0     0     - /sys
tmpfs            tmpfs                  1,9G       0  1,9G    0% /sys/fs/cgroup
securityfs       securityfs                0       0     0     - /sys/kernel/security
debugfs          debugfs                   0       0     0     - /sys/kernel/debug
/dev/sda14       ext4                   384G     72G  311G   19% /home
/dev/sdb1        ext4                     8G      0M    8G    -  /media/storage
linaro-alip@linaro:~>$
```

Notice our sample print out is now detecting a new device at `/dev/sbd1`:

```shell
/dev/sdb1        ext4                     8G       -    8G    -  /media/storage
```

It is important to notice and compare the characteristics of the device to what we know about the device. In our sample we have a type ext4, 8G device with 8G free space. Our host PC has assigned it a device name of `sdb1`.
Your device name can vary, this is why you should check your list of devices before and after inserting the SD card.

It's time to continue with the flashing process.

[Click here to go back](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#install-image-onto-sd-card)

## or 

**Warning:** Executing the sync flag command as outlined above is very
important! Do not skip this step!

**Warning:** Be very careful not to overwrite your hard drive! In most
cases, XXX will be mmcblk0 or sdb. This can be found by using the
following sequence:

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

[Click here to go back](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#install-image-onto-sd-card)

***


## Instructions on how to find microSD card devices name in Mac OS X (XXX)

**Step 1**: Access Terminal (make sure SD card is **NOT** inserted into host PC)

**Step 2**: Run the following command

Code:

```shell
$ diskutil list
```

Sample print out:

```shell
MacUser$ diskutil list
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *251.0 GB   disk0
   1:                        EFI EFI                     209.7 MB   disk0s1
   2:          Apple_CoreStorage Macintosh HD            220.7 GB   disk0s2
   3:                 Apple_Boot Recovery HD             650.0 MB   disk0s3
   4:       Microsoft Basic Data                         29.3 GB    disk0s4
/dev/disk1 (internal, virtual):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:                  Apple_HFS MAC                    +220.4 GB   disk1
```

**Step 3**: Insert SD card and run command again

Code:

```shell    
$ diskutil list
```

Sample print out:
   
```shell 
MacUser$ diskutil list
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *251.0 GB   disk0
   1:                        EFI EFI                     209.7 MB   disk0s1
   2:          Apple_CoreStorage Macintosh HD            220.7 GB   disk0s2
   3:                 Apple_Boot Recovery HD             650.0 MB   disk0s3
   4:       Microsoft Basic Data                         29.3 GB    disk0s4
/dev/disk1 (internal, virtual):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:                  Apple_HFS MAC                    +220.4 GB   disk1
                                 Logical Volume on disk0s2
                                 C5C98C5A-96EE-486D-8A68-C52108524FBD
                                 Unlocked Encrypted
/dev/disk2 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *31.9 GB    disk2
   1:               Windows_NTFS Untitled                31.9 GB    disk2s1
```

Notice our sample print out is now detecting a new device as IDENTIFIER `disk2` with partition `disk2s1`:

```shell
/dev/disk2 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *31.9 GB    disk2
   1:               Windows_NTFS Untitled                31.9 GB    disk2s1
```

It is important to notice and compare the characteristics of the device to what we know about the device. In our sample we have a type Windows_NTFS, 31.9G device. Our host PC has assigned it a device name of `disk2` with a partition of `disk2s1.
**Your device name can vary, this is why you should check your list of devices before and after inserting the SD card.**

It's time to continue with the flashing process.

[Click here to go back](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#install-image-onto-sd-card-1)