[<<< Back to HiKey Crossroads](https://github.com/96boards/documentation/wiki/HiKey-Crossroads)
# HiKey Linux Installation Guide

This Users Guide provides a general overview for getting started with Linux installations on the [HiKey](https://www.96boards.org/products/ce/hikey/). 


If you have found this page without having downloaded the appropriate files, please return to the [HiKey Crossroads](https://github.com/96boards/documentation/wiki/HiKey-Crossroads) to choose your download path!


***

## Linux Host

This section show how to install the Linaro based Debian operating system to your HiKey using the SD Card method on a Linux host computer.
***

- [**Step 1**: Prepare MicroSD card]()
- [**Step 2**: Find SD Card Device name]()
- [**Step 3**: Recall Download Location]()
- [**Step 4**: Unzip _Debian SD Card Install Image_]()
- [**Step 5**: Go to directory with _Debian SD Card Install Image_ folder using Terminal]()
- [**Step 6**: Install Image onto SD Card]()
- [**Step 7**: Prepare HiKey with SD card]()
- [**Step 8**: Install Linaro/Debian onto HiKey]()

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

- Locate SD card install file from Downloads page.
- This file will be needed for the next step.

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

####**Step 6**: Install Image onto SD Card

**Checklist:**

- SD card inserted into host computer
- Recall SD Card device name from [**Step 2**]()
- From within the extraction folder, using the Terminal execute the following commands:

**Execute:**

```shell
sudo dd if=hikey-jessie_alip_2015MMDD-nnn.img of=/dev/XXX bs=4M oflag=sync status=noxfer
```

**Note:**

- `if=hikey-jessie_alip_2015MMDD-nnn.img`: should match the name of the image that was downloaded.
- `of=/dev/XXX`: XXX should match the name of the SD Card device name from [**Step 2**](). Be sure to use the device name with out the partition.
- This command will take some time to execute. Be patient and avoid tampering with the terminal until process has ended.
- Once SD card is done flashing, remove from host computer and set aside for **Step 8**

####**Step 7**: Prepare HiKey with SD card

- Make sure HiKey is unplugged from power
- Connect an HDMI monitor to the HiKey with an HDMI cable, and power on the monitor
- Plug a USB keyboard and/or mouse into either of the two USB connectors on the HiKey
- Insert the microSD card into the HiKey
- Plug power adaptor into HiKey, wait for board to boot up.

####**Step 8**: Install Linaro/Debian onto HiKey

<img src="http://i.imgur.com/F18wlgU.png" data-canonical-src="http://i.imgur.com/F18wlgU.png" width="400" height="250"/>

- If **Steps 1 - 8** were followed correctly, the above screen should be visible from your HiKey
- Select the image to install and click “Install” (or type “i”). OS will be installed into the eMMC memory
- This process can take a few minutes to complete
- Upon completion, “Flashing has completed and OS has installed successfully....” message will appear.

Before clicking "OK":

- Remove the SD Card
- Now click "OK" button and allow HiKey to reboot.

**Congratulations! You are now booting your newly installed operating system directly from eMMC on the HiKey**


***


## Mac OS X Host

This section show how to install the Linaro based Debian operating system to your HiKey using the SD Card method on a Mac OS X host computer.
***

- [**Step 1**: Prepare MicroSD card]()
- [**Step 2**: Find SD Card Device name]()
- [**Step 3**: Recall Download Location]()
- [**Step 4**: Unzip _Debian SD Card Install Image_]()
- [**Step 5**: Go to directory with _Debian SD Card Install Image_ folder using Terminal]()
- [**Step 6**: Install Image onto SD Card]()
- [**Step 7**: Prepare HiKey with SD card]()
- [**Step 8**: Install Linaro/Debian onto HiKey]()

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

- Locate SD card install file from Downloads page.
- This file will be needed for the next step.

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

####**Step 6**: Install Image onto SD Card

**Checklist:**

- SD card inserted into host computer
- Recall SD Card device name from [**Step 2**]()
- Make sure SD Card is unmounted
- From within the extraction folder, using the Terminal execute the following commands:

**Execute:**

```shell
sudo dd if=hikey-jessie_alip_2015MMDD-nnn.img of=/dev/XXX bs=4M
sudo sync
```

**Note:**

- `if=hikey-jessie_alip_2015MMDD-nnn.img`: should match the name of the image that was downloaded.
- `of=/dev/XXX`: XXX should match the name of the SD Card device name from [**Step 2**](). Be sure to use the device name with out the partition.
- This command will take some time to execute. Be patient and avoid tampering with the terminal until process has ended.
- Once SD card is done flashing, remove from host computer and set aside for **Step 8**

####**Step 8**: Prepare HiKey with SD card

- Make sure HiKey is unplugged from power
- Connect an HDMI monitor to the HiKey with an HDMI cable, and power on the monitor
- Plug a USB keyboard and/or mouse into either of the two USB connectors on the HiKey
- Insert the microSD card into the HiKey
- Plug power adaptor into HiKey, wait for board to boot up.

####**Step 9**: Install Linaro/Debian onto HiKey

<img src="http://i.imgur.com/F18wlgU.png" data-canonical-src="http://i.imgur.com/F18wlgU.png" width="400" height="250"/>

- If **Steps 1 - 8** were followed correctly, the above screen should be visible from your HiKey
- Select the image to install and click “Install” (or type “i”). OS will be installed into the eMMC memory
- This process can take a few minutes to complete
- Upon completion, “Flashing has completed and OS has installed successfully....” message will appear.

Before clicking "OK":

- Remove the SD Card
- Now click "OK" button and allow HiKey to reboot.

**Congratulations! You are now booting your newly installed operating system directly from eMMC on the HiKey!**

***

## Windows Host

This section show how to install the Linaro based Debian operating system to your HiKey using the SD Card method on a Windows host computer.
***

- [**Step 1**: Prepare MicroSD card]()
- [**Step 2**: Recall Download Location]()
- [**Step 3**: Unzip _Debian SD Card Install Image_]()
- [**Step 4**: Download the Win32DiskImager tool]()
- [**Step 5**: Use Win32DiskImager tool to flash Debian onto SD Card]()
- [**Step 6**: Prepare HiKey with SD card]()
- [**Step 7**: Install Linaro/Debian onto HiKey]()

***

####**Step 1**: Prepare MicroSD card

- Ensure data from mircoSD card is backed up
- Everything on microSD card will be lost by the end of this procedure.

####**Step 3**: Recall Download Location

- Locate SD card install file from Downloads page.
- This file will be needed for the next step.

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

####**Step 6**: Prepare HiKey with SD card

- Make sure HiKey is unplugged from power
- Connect an HDMI monitor to the HiKey with an HDMI cable, and power on the monitor
- Plug a USB keyboard and/or mouse into either of the two USB connectors on the HiKey
- Insert the microSD card into the HiKey
- Plug power adaptor into HiKey, wait for board to boot up.

####**Step 7**: Install Linaro/Debian onto HiKey

<img src="http://i.imgur.com/F18wlgU.png" data-canonical-src="http://i.imgur.com/F18wlgU.png" width="400" height="250"/>

- If **Steps 1 - 6** were followed correctly, the above screen should be visible from your HiKey
- Select the image to install and click “Install” (or type “i”). OS will be installed into the eMMC memory
- This process can take a few minutes to complete
- Upon completion, “Flashing has completed and OS has installed successfully....” message will appear.

Before clicking "OK":

- Remove the SD Card
- Now click "OK" button and allow HiKey to reboot.

**Congratulations! You are now booting your newly installed operating system directly from eMMC on the HiKey!**

***

# Install Debian Using Fastboot

***
##Linux Host

This section show how to install the Linaro based Debian operating system to your DragonBoard™ 410c using the fastboot method on a Linux host computer.

***

- [**Step 1**: Make sure fastboot is set up on host computer]()
- [**Step 2**: Connect host computer to DragonBoard™ 410c]()
- [**Step 3**: Boot DragonBoard™ 410c into fastboot mode]()
- [**Step 4**: Flash Bootloader]()
- [**Step 5**: Recall location of `boot` and `rootfs` download from the downloads page]()
- [**Step 6**: Unzip both 'boot' and 'rootfs' files]()
- [**Step 7**: Flash `boot` image and `rootfs` to the DragonBoard™ 410c]()
- [**Step 8**: Reboot DragonBoard™ 410c]()

***

**Step 1**: Make sure fastboot is set up on host computer. 

- Android SDK “Tools only” for Linux can be downloaded <a href="http://developer.android.com/sdk" target="_blank">here</a>
- The Linux “Tools Only” SDK download does not come with fastboot, you will need to use the Android SDK Manager to install platform-tools.
- To do this follow the “SDK Readme.txt” instructions included in your SDK “Tools Only” download.

If you are still having trouble setting up fastboot, <a href="https://youtu.be/W_zlydVBftA" target="_blank">click here</a> for a short tutorial video

**Step 2**: Connect host computer to DragonBoard™ 410c

**Step 3**: Boot DragonBoard™ 410c into fastboot mode

**Step 4**: Flash Bootloader

**Step 5**: Recall location of `boot` and `rootfs` download from the downloads page

**Step 6**: Unzip both 'boot' and 'rootfs' files

**Step 7**: Flash `boot` image and `rootfs` to the DragonBoard™ 410c

**Step 8**: Reboot DragonBoard™ 410c

- Unplug power to DragonBoard™ 410c
- Unplug micro USB cable from DragonBoard™ 410c
- Ensure HDMI connection to monitor
- Ensure keyboard and/or mouse connection (Depending on your rootfs selection)
- Plug power back into DragonBoard™ 410c
- Wait for board to boot up
- Board will boot into either command line or desktop depending on rootfs

**Note:** the **username** and **password** are both **“linaro”** when the login information is requested.

**Congratulations! You are now booting your newly installed OS directly
from eMMC on the DragonBoard™ 410c!**
