[<<< Back to HiKey Crossroads](https://github.com/96boards/documentation/wiki/HiKey-Crossroads)
# HiKey AOSP Installation Guide

This Users Guide provides a general overview for getting started with Linux installations on the [HiKey](https://www.96boards.org/products/ce/hikey/). 


If you have found this page without having downloaded the appropriate files, please return to the [HiKey Crossroads](https://github.com/96boards/documentation/wiki/HiKey-Crossroads) to choose your download path!


***

# Install AOSP Using Fastboot

***
##Linux Host

This section show how to install the AOSP operating system to your HiKey using the fastboot method on a Linux host computer.

***

- [**Step 1**: Make sure fastboot is set up on host computer]()
- [**Step 2**: Boot HiKey into Fastboot mode using J15 header]()
- [**Step 3**: Set HiKey into Recovery Mode using J15 header]()
- [**Step 4**: Install Operating System update using downloaded files]()
- [**Step 5**: Reboot HiKey into new OS]()

***

**Step 1**: Make sure fastboot is set up on host computer 

- Android SDK “Tools only” for Linux can be downloaded <a href="http://developer.android.com/sdk" target="_blank">here</a>
- The Linux “Tools Only” SDK download does not come with fastboot, you will need to use the Android SDK Manager to install platform-tools.
- To do this follow the “SDK Readme.txt” instructions included in your SDK “Tools Only” download.

If you are still having trouble setting up fastboot, <a href="https://youtu.be/W_zlydVBftA" target="_blank">click here</a> for a short tutorial video

**Step 2**: Boot HiKey into Fastboot mode using J15 header

- Link pins 1 and 2
- Link pins 5 and 6
- Connect host computer to HiKey board using USB to microUSB cable

Name | Link | State
---- | ---- | -----
Auto Power up | Link 1-2 | closed
Boot Select | Link 3-4 | open
GPIO3-1 | Link 5-6 | closed

- Power on HiKey board by plugging in power adapter
- Esure HiKey is detected by host computere
- Open Terminal application and execute the following:

```shell
$ sudo fastboot devices
0123456789abcdef fastboot
```

>Note: If your HiKey is not being detected by fastboot, you might want to try [Board Recovery](https://github.com/96boards/documentation/wiki/HiKey-Board-Recovery) and return to this step once your board is ready

**Step 3**: Set HiKey into Recovery Mode using J15 header

- Remove link between pins 5 and 6
- Link pins 1 and 2
- Link pins 3 and 4

Name | Link | State
---- | ---- | -----
Auto Power up | Link 1-2 | closed
Boot Select | Link 3-4 | closed
GPIO3-1 | Link 5-6 | open

**Step 4**: Install Operating System update using downloaded files

>**NOTE:** the ptable must be flashed first. Wait for a few seconds after the reboot command to allow the bootloader to restart using the new partition table.

```shell
$ sudo fastboot flash ptable ptable-aosp-8g.img
$ sudo fastboot reboot
$ sudo fastboot flash boot boot_fat.uefi.img
$ sudo fastboot flash cache cache.img
$ sudo fastboot flash system system.img
$ sudo fastboot flash userdata userdata-8gb.img
```

**Step 5**: Reboot HiKey into new OS

- Wait untill all files have been flashed onto HiKey board
- Power down HiKey by unplugging the power adapter
- Remove microUSB cable from HiKey
- Remove Link 3-4 from J15 header

Name | Link | State
---- | ---- | -----
Auto Power up | Link 1-2 | closed
Boot Select | Link 3-4 | open
GPIO3-1 | Link 5-6 | open

- Plug mouse/keyboard USB into type A USB ports
- Power up HiKey by plugging in power adapter


**Note:** the **username** and **password** are both **“linaro”** when the login information is requested.

**Congratulations! You are now booting your newly installed OS directly
from eMMC on the HiKey!**