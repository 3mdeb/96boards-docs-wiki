[<<< Back to DragonBoard™ 410c Home](https://github.com/96boards/documentation/wiki/Dragonboard-410c)
# Dragonboard™ 410c Linux Installation Guide


This Users Guide provides a general overview for getting started with Linux installations on the [DragonBoard™ 410c](https://www.96boards.org/products/ce/dragonboard410c/). 

There are two primary ways to install software onto the DragonBoard™ 410c:
- SD Card
- Fastboot

**Making your way through this document is easy!**

1. Read about both installation methods
2. Choose your method
3. Download file(s) and Choose your Host Machine (This is the machine you will be using throughout the process)
4. Follow your custom set of steps

If you are having trouble with this document please <a href="https://youtu.be/JoL1rQhJKuA" target="_blank">click here</a> for a video walkthrough.



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

#### Step 3: Download file(s) and Choose your Host Machine

##**Download:**

Debian SD Card Install Image ([Direct Download](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/dragonboard410c_sdcard_install_debian*.zip) / [View Build Folder](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/latest/))


- [**Linux Host**](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#linux-host)
- [**Mac OSX Host**](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#mac-osx-host)
- [**Windows Host**](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#windows-host)


***


## Linux Host

This section show how to install the Linaro based Debian operating system to your DragonBoard™ 410c using a Linux host computer.


- [**Step 1**: Prepare MicroSD card]()
- [**Step 2**: Find SD Card Device name]()
- [**Step 3**: Recall Download Location]()
- [**Step 4**: Unzip _Debian SD Card Install Image_]()
- [**Step 5**: Go to directory with _Debian SD Card Install Image_ folder using Terminal]()
- [**Step 6**: Locate SD Card Install Image]()
- [**Step 7**: Install Image onto SD Card]()
- [**Step 8**: Prepare DragonBoard™ 410c with SD card]()
- [**Step 9**: Install Linaro/Debian onto DragonBoard™ 410c]()

***

####**Step 1**: Prepare MicroSD card

- Ensure data from mircoSD card is backed up
- Everything on microSD card will be lost by the end of this procedure.

####**Step 2**: Find SD Card Device name

- Use host computer
- Open "Terminal" application
- Remove SD card from host computer and run the following command:
```shell
lsblk
```
- Note all recognized disk names
- **Insert SD card** and run the following command (again):
```shell
lsblk
```
- Note the newly recognized disk. This will be your SD card.
- **Remember** your SD card device name, it will be needed in **Step 7**.

####**Step 3**: Recall Download Location

- Location of download will be needed in later steps

####**Step 4**: Unzip _Debian SD Card Install Image_

- When unzipped, you will have a folder with the following contents:
   - Linaro/Debian Install Image (.img)
   - Readme

####**Step 5**: Go to directory with _Debian SD Card Install Image_ folder using Terminal

- Use host computer
- Open "Terminal" application
- `cd` to the directory with your unzipped **Debian SD Card Install Image**

```shell
cd <extraction directory>

#Example: 
#<extraction directory> = /home/YourUserName/Downloads
#For this example we assume the "Debian SD Card Install Image" is in the Downloads folder.
cd /home/YourUserName/Downloads
```

####**Step 6**: Locate SD Card Install Image

- Make sure you are in the extraction directory

**Unzipped Debian SD Card download will be a folder. This folder should be listed in your directory. Type `ls` from command line for a list of files that can be found in your current directory**:

```shell
ls

#output
dragonboard410c_sdcard_install_debian-XX
```

- Unzipped folder should be called dragonboard410c_sdcard_install_debian-XX, where XX represents the Debian release number
- `cd` into this directory

```shell
cd dragonboard410c_sdcard_install_debian-XX
```

- Inside this folder you will find the install image
   - `db410c_sd_install_debian.img`
- This `.img` file is what will be flashed to your SD Card.

####**Step 7**: Install Image onto SD Card

**Checklist:**

- SD card inserted into host computer
- Recall SD Card device name from [**Step 2**](https://github.com/sdrobertw/test-wiki-/wiki/Linux-host-SD-CARD#step-2-find-sd-card-device-name)
- From within the dragonboard410c_sdcard_install_debian-XX folder, using the Terminal execute the following commands:

**Execute:**

```shell
sudo dd if=db410c_sd_install_debian.img of=/dev/XXX bs=4M oflag=sync status=noxfer
```

**Note:**

- `if=db410c_sd_install_debian.img`: should match the name of the image that was downloaded.
- `of=/dev/XXX`: XXX should match the name of the SD Card device name from [**Step 2**](https://github.com/sdrobertw/test-wiki-/wiki/Linux-host-SD-CARD#step-2-find-sd-card-device-name). Be sure to use the device name with out the partition.
- This command will take some time to execute. Be patient and avoid tampering with the terminal until process has ended.
- Once SD card is done flashing, remove from host computer and set aside for **Step 8**

####**Step 8**: Prepare DragonBoard™ 410c with SD card

- Make sure DragonBoard™ 410c is unplugged from power
- Set S6 switch on DragonBoard™ 410c to `0-1-0-0`, "SD Boot switch" should be set to "ON".
   - Please see "1.1 Board Overview" on page 7 from [DragonBoard™ 410c Hardware Manual](http://linaro.co/96b-hwm-db) if you cannot find S6
- Connect an HDMI monitor to the DragonBoard™ 410c with an HDMI cable, and power on the monitor
- Plug a USB keyboard and/or mouse into either of the two USB connectors on the DragonBoard™ 410c
- Insert the microSD card into the DragonBoard™ 410c
- Plug power adaptor into DragonBoard™ 410c, wait for board to boot up.

####**Step 9**: Install Linaro/Debian onto DragonBoard™ 410c

<img src="http://i.imgur.com/F18wlgU.png" data-canonical-src="http://i.imgur.com/F18wlgU.png" width="400" height="250"/>

- If **Steps 1 - 8** were followed correctly, the above screen should be visible from your DragonBoard™ 410c
- Select the image to install and click “Install” (or type “i”). OS will be installed into the eMMC memory
- This process can take a few minutes to complete
- Upon completion, “Flashing has completed and OS has installed successfully....” message will appear.

Before clicking "OK":

- Remove the SD Card
- Set S6 switch on DragonBoard™ 410c to `0-0-0-0`, all switches should be set to "OFF"
- Now click "OK" button and allow DragonBoard™ 410c to reboot.

**Congratulations! You are now booting your newly installed operating system directly from eMMC on the DragonBoard™ 410c!**


***


## Mac OSX Host

This section show how to install the Linaro based Debian operating system to your DragonBoard™ 410c using a Mac OS X host computer.


- [**Step 1**: Prepare MicroSD card]()
- [**Step 2**: Find SD Card Device name]()
- [**Step 3**: Recall Download Location]()
- [**Step 4**: Unzip _Debian SD Card Install Image_]()
- [**Step 5**: Go to directory with _Debian SD Card Install Image_ folder using Terminal]()
- [**Step 6**: Locate SD Card Install Image]()
- [**Step 7**: Install Image onto SD Card]()
- [**Step 8**: Prepare DragonBoard™ 410c with SD card]()
- [**Step 9**: Install Linaro/Debian onto DragonBoard™ 410c]()

***

####**Step 1**: Prepare MicroSD card

- Ensure data from mircoSD card is backed up
- Everything on microSD card will be lost by the end of this procedure.

####**Step 2**: Find SD Card Device name

- Use host computer
- Open "Terminal" application **(Press Command+Space bar and type "Terminal")**
- Remove SD card from host computer and run the following command:
```shell
diskutil list
```
- Note all recognized disk names
- **Insert SD card** and run the following command (again):
```shell
diskutil list
```
- Note the newly recognized disk. This will be your SD card.
- **Remember** your SD card device name, it will be needed in **Step 7**.

####**Step 3**: Recall Download Location

- Location of download will be needed in later steps

####**Step 4**: Unzip _Debian SD Card Install Image_

- When unzipped, this download will be a folder with the falling contents
   - Linaro/Debian Install Image (.img)
   - Readme

####**Step 5**: Go to directory with _Debian SD Card Install Image_ folder using Terminal

- Use host computer
- Open "Terminal" application **(Press Command+Space bar and type "Terminal")**
- `cd` to the directory with your unzipped **Debian SD Card Install Image**

```shell
cd <extraction directory>

#Example: 
#<extraction directory> = /Users/YourUserName/Downloads
#For this example we assume the "Debian SD Card Install Image" is in the Downloads folder.
cd /Users/YourUserName/Downloads
```

####**Step 6**: Locate SD Card Install Image

- Make sure you are in the extraction directory

**Unzipped Debian SD Card download will be a folder. This folder should be listed in your directory. Type `ls` from command line for a list of files that can be found in your current directory**:

```shell
ls

#output
dragonboard410c_sdcard_install_debian-XX
```

- Unzipped folder should be called dragonboard410c_sdcard_install_debian-XX, where XX represents the Debian release number
- `cd` into this directory

```shell
cd dragonboard410c_sdcard_install_debian-XX
```

- Inside this folder you will find the install image
   - `db410c_sd_install_debian.img`
- This `.img` file is what will be flashed to your SD Card.

####**Step 7**: Install Image onto SD Card

**Checklist:**

- SD card inserted into host computer
- Recall SD Card device name from [**Step 2**]()
- From within the dragonboard410c_sdcard_install_debian-XX folder, using the Terminal execute the following commands:

**Execute:**

```shell
$ sudo dd if=db410c_sd_install_debian-YY.img of=/dev/XXX bs=4m
$ sudo sync
```

**Note:**

- `if=db410c_sd_install_debian.img`: should match the name of the image that was downloaded.
- `of=/dev/XXX`: XXX should match the name of the SD Card device name from [**Step 2**](https://github.com/sdrobertw/test-wiki-/wiki/Linux-host-SD-CARD#step-2-find-sd-card-device-name). Be sure to use the device name with out the partition.
- This command will take some time to execute. Be patient and avoid tampering with the terminal until process has ended.
- Once SD card is done flashing, remove from host computer and set aside for **Step 8**

####**Step 8**: Prepare DragonBoard™ 410c with SD card

- Make sure DragonBoard™ 410c is unplugged from power
- Set S6 switch on DragonBoard™ 410c to `0-1-0-0`, "SD Boot switch" should be set to "ON".
   - Please see "1.1 Board Overview" on page 7 from [DragonBoard™ 410c Hardware Manual](http://linaro.co/96b-hwm-db) if you cannot find S6
- Connect an HDMI monitor to the DragonBoard™ 410c with an HDMI cable, and power on the monitor
- Plug a USB keyboard and/or mouse into either of the two USB connectors on the DragonBoard™ 410c
- Insert the microSD card into the DragonBoard™ 410c
- Plug power adaptor into DragonBoard™ 410c, wait for board to boot up.

####**Step 9**: Install Linaro/Debian onto DragonBoard™ 410c

<img src="http://i.imgur.com/F18wlgU.png" data-canonical-src="http://i.imgur.com/F18wlgU.png" width="400" height="250"/>

- If **Steps 1 - 8** were followed correctly, the above screen should be visible from your DragonBoard™ 410c
- Select the image to install and click “Install” (or type “i”). OS will be installed into the eMMC memory
- This process can take a few minutes to complete
- Upon completion, “Flashing has completed and OS has installed successfully....” message will appear.

Before clicking "OK":

- Remove the SD Card
- Set S6 switch on DragonBoard™ 410c to `0-0-0-0`, all switches should be set to "OFF"
- Now click "OK" button and allow DragonBoard™ 410c to reboot.

**Congratulations! You are now booting your newly installed operating system directly from eMMC on the DragonBoard™ 410c!**


***



## Windows Host

This section show how to install the Linaro based Debian operating system to your DragonBoard™ 410c using a Windows host computer.


- [**Step 1**: Prepare MicroSD card]()
- [**Step 2**: Recall Download Location]()
- [**Step 3**: Unzip _Debian SD Card Install Image_]()
- [**Step 4**: Download the Win32DiskImager tool]()
- [**Step 5**: Use Win32DiskImager tool to flash Debian onto SD Card]()
- [**Step 6**: Prepare DragonBoard™ 410c with SD card]()
- [**Step 7**: Install Linaro/Debian onto DragonBoard™ 410c]()

***

####**Step 1**: Prepare MicroSD card

- Ensure data from mircoSD card is backed up
- Everything on microSD card will be lost by the end of this procedure.

####**Step 2**: Recall Download Location

- Location of download will be needed in later steps

####**Step 3**: Unzip _Debian SD Card Install Image_

- When unzipped, this download will be a folder with the falling contents
   - Linaro/Debian Install Image (.img)
   - Readme

####**Step 4**: Download the Win32DiskImager tool

- Win32DiskImager tool ([Direct Download](https://sourceforge.net/projects/win32diskimager/files/latest/download) / <a href="http://sourceforge.net/projects/win32diskimager/" target="_blank">Go to Site</a>)

####**Step 5**: Use Win32DiskImager tool to flash Debian onto SD Card

- Open Win32DiskImager tool
- Click the folder icon in the top right
- Find your way to the appropriate `.img` file (This is why you need to remember the location of your extracted image.)

<img src="http://i.imgur.com/cqk6LhL.png" data-canonical-src="http://i.imgur.com/cqk6LhL.png" width="300" height="150"/>

- Insert your microSD card (through a USB SD card-reader, if necessary)
- Select the correct device and click "write" There may be a warning about corrupting the device. Click "Yes" to proceed.
- This process may take a few minutes, be patient and wait for a completion notice.
- Upon completion you should see the following pop-up:

<img src="http://i.imgur.com/HzYujlw.png" data-canonical-src="http://i.imgur.com/HzYujlw.png" width="150" height="100"/>

- Eject SD Card and proceed to next **Step**

####**Step 6**: Prepare DragonBoard™ 410c with SD card

- Make sure DragonBoard™ 410c is unplugged from power
- Set S6 switch on DragonBoard™ 410c to `0-1-0-0`, "SD Boot switch" should be set to "ON".
   - Please see "1.1 Board Overview" on page 7 from [DragonBoard™ 410c Hardware Manual](http://linaro.co/96b-hwm-db) if you cannot find S6
- Connect an HDMI monitor to the DragonBoard™ 410c with an HDMI cable, and power on the monitor
- Plug a USB keyboard and/or mouse into either of the two USB connectors on the DragonBoard™ 410c
- Insert the microSD card into the DragonBoard™ 410c
- Plug power adaptor into DragonBoard™ 410c, wait for board to boot up.

####**Step 7**: Install Linaro/Debian onto DragonBoard™ 410c

<img src="http://i.imgur.com/F18wlgU.png" data-canonical-src="http://i.imgur.com/F18wlgU.png" width="400" height="250"/>

- If **Steps 1 - 6** were followed correctly, the above screen should be visible from your DragonBoard™ 410c
- Select the image to install and click “Install” (or type “i”). OS will be installed into the eMMC memory
- This process can take a few minutes to complete
- Upon completion, “Flashing has completed and OS has installed successfully....” message will appear.

Before clicking "OK":

- Remove the SD Card
- Set S6 switch on DragonBoard™ 410c to `0-0-0-0`, all switches should be set to "OFF"
- Now click "OK" button and allow DragonBoard™ 410c to reboot.

**Congratulations! You are now booting your newly installed operating system directly from eMMC on the DragonBoard™ 410c!**


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

**Step 1**: Make sure fastboot is set up on host computer. Android SDK “Tools only” for Linux can be downloaded [here](http://developer.android.com/sdk)


- The Linux “Tools Only” SDK download does not come with fastboot, you will need to use the Android SDK Manager to install platform-tools.
- To do this follow the “SDK Readme.txt” instructions included in your SDK “Tools Only” download.

If you are still having trouble setting up fastboot, <a href="https://youtu.be/W_zlydVBftA" target="_blank">click here</a> for a short tutorial video

**Step 2**: Connect host computer to DragonBoard™ 410c

- DragonBoard™ 410c must be powered off (unplugged from power)
- Make sure microSD card slot on DragonBoard™ 410c is empty
- S6 switch on DragonBoard™ 410c must be set to ‘0-0-0-0’. All switches should be in “off” position
- Connect USB to microUSB cable from host computer to DragonBoard™ 410c

**Step 3**: Boot DragonBoard™ 410c into fastboot mode

**Please read all bullet points before attempting**

- Press and hold the Vol (-) button on the DragonBoard™ 410c, this is the S4 button. DragonBoard™ 410c should still NOT be powered on
- While holding the Vol (-) button, power on the DragonBoard™ 410c by plugging it in
- Once DragonBoard™ 410c is plugged into power, release your hold on the Vol (-) button.
- Board should boot into fastboot mode.

From the connected host machine terminal window, run the following commands:

```shell
# Check to make sure fastboot device is connected

fastboot devices
```

**At this point you should be connected to your DragonBoard™ 410c with a USB to microUSB cable. Your DragonBoard™ 410c should be booted into fastboot mode and ready to be flashed with the appropriate images.**


***


### Flash Bootloader into on-board eMMC

In this section we will continue by downloading and flashing the bootloader onto your DragonBoard™ 410c. This will be achieved by accessing and executing a script located in the downloaded bootloader folder.

**Step 1**: Download Bootloader

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

**Congratulations! You are now booting your newly installed OS directly
from eMMC on the DragonBoard™ 410c!**

## Mac OSX Host

- [Getting Started](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#getting-started-4)
- [Flash Bootloader into on-board eMMC](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flash-bootloader-into-on-board-emmc-1)
- [Flash Linaro/Debian Release](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flash-linarodebian-release-1)

### Getting Started

This section will explain the fastboot method for installation of the Linux images onto
the DragonBoard™ 410c.  

**Step 1**: Make sure fastboot is set up on host computer. Android SDK “Tools only” for Mac OS X can be downloaded [here](http://developer.android.com/sdk)

- The Mac OS X “Tools Only” SDK download does not come with fastboot, you will need to use the Android SDK Manager to install platform-tools.
- To do this follow the “SDK Readme.txt” instructions included in your SDK “Tools Only” download.

If you are still having trouble setting up fastboot, [click here]()(Coming Soon) for a short tutorial video

**Step 2**: Connect host computer to DragonBoard™ 410c

- DragonBoard™ 410c must be powered off (unplugged from power)
- Make sure microSD card slot on DragonBoard™ 410c is empty
- S6 switch on DragonBoard™ 410c must be set to ‘0-0-0-0’. All switches should be in “off” position
- Connect USB to microUSB cable from host computer to DragonBoard™ 410c

**Step 3**: Boot DragonBoard™ 410c into fastboot mode

**Please read all bullet points before attempting**

- Press and hold the Vol (-) button on the DragonBoard™ 410c, this is the S4 button. DragonBoard™ 410c should still NOT be powered on
- While holding the Vol (-) button, power on the DragonBoard™ 410c by plugging it in
- Once DragonBoard™ 410c is plugged into power, release your hold on the Vol (-) button.
- Board should boot into fastboot mode.

From the connected host machine terminal window, run the following commands:

```shell
# Check to make sure fastboot device is connected

fastboot devices
```

**At this point you should be connected to your DragonBoard™ 410c with a USB to microUSB cable. Your DragonBoard™ 410c should be booted into fastboot mode and ready to be flashed with the appropriate images.**


***


### Flash Bootloader into on-board eMMC

In this section we will continue by downloading and flashing the bootloader onto your DragonBoard™ 410c. This will be achieved by accessing and executing a script located in the downloaded bootloader folder.

**Step 1**: Download Bootloader

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

**Congratulations! You are now booting your newly installed OS directly
from eMMC on the DragonBoard™ 410c!**

***

## Windows Host (In Progress)

- [Getting Started](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#getting-started-5)
- [Flash Bootloader into on-board eMMC](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flash-bootloader-into-on-board-emmc-2)
- [Flash Linaro/Debian Release](https://github.com/96boards/documentation/wiki/DragonBoard410c-Linux-Install#flash-linarodebian-release-2)

### Getting Started

This section will explain the fastboot method for installation of the Linux images onto
the DragonBoard™ 410c. 

**Step 1**: Make sure fastboot is set up on host computer. Android SDK “Tools only” for Windows can be downloaded [here](http://developer.android.com/sdk)

- The Windows “Tools Only” SDK download does not come with fastboot, you will need to use the Android SDK Manager to install platform-tools.
- To do this follow the “SDK Readme.txt” instructions included in your SDK “Tools Only” download.

If you are still having trouble setting up fastboot, [click here]()(Coming soon) for a short tutorial video

**Step 2**: Connect host computer to DragonBoard™ 410c

- DragonBoard™ 410c must be powered off (unplugged from power)
- Make sure microSD card slot on DragonBoard™ 410c is empty
- S6 switch on DragonBoard™ 410c must be set to ‘0-0-0-0’. All switches should be in “off” position
- Connect USB to microUSB cable from host computer to DragonBoard™ 410c

**Step 3**: Boot DragonBoard™ 410c into fastboot mode

**Please read all bullet points before attempting**

- Press and hold the Vol (-) button on the DragonBoard™ 410c, this is the S4 button. DragonBoard™ 410c should still NOT be powered on
- While holding the Vol (-) button, power on the DragonBoard™ 410c by plugging it in
- Once DragonBoard™ 410c is plugged into power, release your hold on the Vol (-) button.
- Board should boot into fastboot mode.

From the connected host machine terminal window, run the following commands:

```shell
# Check to make sure fastboot device is connected

fastboot devices
```

**At this point you should be connected to your DragonBoard™ 410c with a USB to microUSB cable. Your DragonBoard™ 410c should be booted into fastboot mode and ready to be flashed with the appropriate images.**


***


### Flash Bootloader into on-board eMMC

In this section we will continue by downloading and flashing the bootloader onto your DragonBoard™ 410c. This will be achieved by accessing and executing a script located in the downloaded bootloader folder.

**Step 1**: Download Bootloader

[Bootloader zip](http://builds.96boards.org/releases/dragonboard410c/linaro/rescue/latest/dragonboard410c_bootloader_emmc_linux-40.zip)

**Step 2**: Flash Bootloader

Open up terminal and execute the following commands:

```shell
# cd to the directory the bootloader zip file was extracted
cd <extraction directory>

#rename flashall to flashall.bat and execute

flashall.bat
```
**Note:** fastboot, bootloader files, and flashall.bat script must all be in the same directory.

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

**Note**: 'fastboot', 'boot' file, and 'rootfs' file must all be in the same directory.

```shell
# Check to make sure fastboot device connected.  If not resolve
$ fastboot devices

# cd to the directory the boot image and RootFS were extracted
$ cd <extraction directory>

# Make sure you have properly unzipped the boot and rootfs downloads
fastboot flash boot boot-linaro-jessie-qcom-snapdragon-arm64-**BUILD#**.img
fastboot flash rootfs linaro-jessie-developer-qcom-snapdragon-arm64-**BUILD#**.img
```
**Note**: Replace **BUILD#** in the above commands with the file-specific date/build stamp.

Now reboot the DragonBoard™ 410c using the following sequence and it will boot to the command prompt:

- Unplug the power to the DragonBoard™ 410c
- Unplug the micro USB fastboot cable
- Make sure you are plugged in to a HDMI monitor, keyboard and/or mouse depending on your rootfs
- Plug the power back into the DragonBoard™ 410c

**Note:** the **username** and **password** are both **“linaro”** when the login information is requested.

**Congratulations! You are now booting your newly installed OS directly
from eMMC on the DragonBoard™ 410c!**

***

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