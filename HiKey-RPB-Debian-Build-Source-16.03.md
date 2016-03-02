[<<< Back to Reference Platform Home](https://github.com/96boards/documentation/wiki/Reference-Platform-Home)


- [Building Linux Kernel from Source](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#building-the-linux-kernel-from-source)
   - [Step 1: Setting up your environment on your host computer ](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-1-setting-up-your-environment-on-your-host-computer)
   - [Step 2: Download the Linaro cross compiler toolchain and Skales Tool](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-2-download-the-linaro-cross-compiler-toolchain-and-skales-tool)
   - [Step 3: Export path to cross compiler tool and confirm version](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-3-export-path-to-cross-compiler-tool-and-confirm-version)
   - [Step 4: Clone the Reference Platform kernel](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-4-clone-the-reference-platform-kernel)
   - [Step 5: Set the right kernel .config file](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-5-set-the-right-kernel-config-file)
   - [Step 6: Build kernel image](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-6-build-kernel-image)
   - [Step 7: Copy Modules](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-7-copy-modules)
   - [Step 8: Find kernel release string](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-8-find-kernel-release-string)
   - [Step 9: Generate modules.dep and map files](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-9-generate-modulesdep-and-map-files)
   - [Step 10: Find DragonBoard™ 410c IP Address](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-10-find-hikey-ip-address)
   - [Step 11: Transfer the modules to the target HiKey](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-11-transfer-the-modules-to-the-target-hikey)
   - [Step 12: Generate the initramfs](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-12-generate-the-initramfs)
   - [Step 13: Create the device tree image and boot image](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#step-13-create-the-device-tree-image-and-boot-image)
- [Customize Bootloader](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#boot-loader)
- [Build Rootfs from source](https://github.com/96boards/documentation/wiki/HiKey-RPB-Debian-Build-Source-16.03#todo)

***

#### Building the Linux kernel from source

The Linux kernel used in this release is available via tags in the git [repository](https://github.com/96boards/linux)

```shell
git: https://github.com/96boards/linux
Dynamic tag: 96b-kernelci
Fixed tag: 96b/releases/2016.03
defconfig: arch/arm64/defconfig kernel/configs/distro.config
```

The kernel image (`Image`) is located in the `boot` image and partition and the kernel modules are installed in the root file system. It is possible for a user to rebuild the kernel and run a custom kernel image instead of the released kernel. You can build the kernel using any recent GCC release using the git tree, tag and defconfig mentioned above. This release only supports booting with device tree, as such both the device tree blobs need to be built as well.

The DragonBoard 410c is an ARMv8 platform, and the kernel is compiled for the Aarch64 target. Even though it is possible to build natively, on the target board, It is recommended to build the Linux kernel on a PC development host. In which case you need to install a cross compiler for the ARM architecture. It is recommended to download the Linaro GCC cross compiler [Aarch64 little-endian](http://releases.linaro.org/components/toolchain/binaries/latest-5.1/aarch64-linux-gnu/gcc-linaro-5.1-2015.08-x86_64_aarch64-linux-gnu.tar.xz).

To build the Linux kernel, you can use the following instructions:

#### Step 1: Setting up your environment on your host computer

- Open your Terminal and cd into your desired directory
- Make a new folder using `mkdir` and call is something relevant

```shell
#Example of desired directory
$ cd ~/Desktop

#Example of relevant folder
$ mkdir HiKey-16.03
$ cd HiKey-16.03
```

#### Step 2: Download the Linaro cross compiler toolchain and Skales Tool

- From within the directory you just made
- Download and unzip by executing the following commands

###### Linaro Cross Compiler

```shell
#Download
$ wget http://releases.linaro.org/components/toolchain/binaries/latest-5.1/aarch64-linux-gnu/gcc-linaro-5.1-2015.08-x86_64_aarch64-linux-gnu.tar.xz
#Unzip
$ tar -Jxvf gcc-linaro-5.1-2015.08-x86_64_aarch64-linux-gnu.tar.xz
```

###### Skales tool

```shell
$ sudo apt-get install libfdt-dev
$ git clone git://codeaurora.org/quic/kernel/skales /tmp/skales
$ export PATH=$PATH:/tmp/skales
```
>Skales will be used later when creating the device tree


#### Step 3: Export path to cross compiler tool and confirm version

- Exporting path will allow build system can find and use the right kernel

```shell
#Create path
$ export PATH=gcc-linaro-5.1-2015.08-x86_64_aarch64-linux-gnu/bin/:$PATH
#Check version
$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Linaro GCC 5.1-2015.08) 5.1.1 20150608
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

#### Step 4: Clone the Reference Platform kernel

- **96b-kernelci** is the development branch
- This branch will have the latest changes

```shell
$ git clone -b 96b-kernelci http://github.com/96boards/linux.git
```

- Cloning the kernel may take a few minutes
- Once kernel source has been cloned cd into its directory

```shell
$ cd kernel
```

#### Step 5: Set the right kernel .config file

- This step creates the '.config' file
- The .config file is used by the build system when compiling the kernel
- Current Reference Platform config can be made by using distro.config
- From with in kernel directory execute the following command:

```shell
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig distro.config
```

- New .config file will be hidden but can be seen by executing `ls -a` from within kernel folder
- To view all current configuration the .config file can be opened with a text editor such a `vim`

#### Step 6: Build kernel image

- This step will take some time (~20-30 minutes or more), depending on your cpu/memory

```shell
#Replace X from -jX with the number of cores on your host computer
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -jX
```

#### Step 7: Copy Modules

- Modules must be local (host computer) before transferring to target device
- Still within linux directory
- Make temp folder
- Create modules

```shell
$ mk tmp/modules
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- modules_install INSTALL_MOD_PATH=/tmp/modules INSTALL_MOD_STRIP=1
```

#### Step 8: Find kernel release string

- This was created during the kernel build
- In this example the kernel.release is 4.4.0+

```shell
$ cat include/config/kernel.release
#Output
$ 4.4.0+
```

#### Step 9: Generate modules.dep and map files

- Helps kernel find modules when system boots
- Note: `4.4.0+` was the output from `cat include/config/kernel.release` in Step 8

```shell
$ depmod -a -b /tmp/modules 4.4.0+
```

#### Step 10: Find HiKey IP Address

- On your HiKey board
- Connect to the internet through WIFI
- Open one of the Terminal applications

```shell
$ /sbin/ifconfig
```
- Look for your `wlan0` connection
- Here you will see an `inet addr`
- This is your board's IP address and should look something like this: `192.168.0.10`

#### Step 11: Transfer the modules to the target HiKey

- Using your board's IP Address for linaro@<yourIPaddress>

```shell
$ tar -cjf /tmp/modules.tar.bz2 -C /tmp modules
$ scp /tmp/modules.tar.bz2 linaro@192.168.1.15:~/
$ ssh linaro@192.168.1.15
#HiKey shell
hikey $ tar -jxvf modules.tar.bz2
hikey $ sudo cp -r modules/lib/modules/4.4.0+ /lib/modules/
```

#### Step 12: Generate the initramfs

- You should still be in the HiKey shell

```shell
hikey $ sudo update-initramfs -k 4.4.0+ -c
```

- Copy back the new initramfs
- This will be used when creating the boot.mg

#### Step 13: Create the device tree image and boot image

###### Device tree

```shell
$ dtbTool -o dt.img -s 2048 arch/arm64/boot/dts/qcom
```

###### Boot image

```shell
$ mkbootimg --kernel arch/arm64/boot/Image --ramdisk initrd.img-4.4.0+ --output boot.img --dt dt.img --pagesize "2048" --base "0x80000000" --cmdline "root=/dev/disk/by-partlabel/rootfs rw rootwait console=tty0 console=ttyMSM0,115200n8"
```

Congratulations! Boot image is now ready to be flashed to your HiKey.

- Flashing the boot image can be done using fastboot
- Board must be booted into fastboot mode
- With USB to microUSB cable still connect execute the following:

```shell
$ sudo fastboot flash boot boot.img
$ sudo fastboot reboot
```

To boot using your own kernel, simply copy the kernel, modules and device tree to the root file system (similar to desktops), and create your own grub entry at `/boot/grub/grub.cfg`.


### Boot Loader

Please see [https://github.com/96boards/documentation/wiki/Reference-Bootloader-Hikey#building-from-source](https://github.com/96boards/documentation/wiki/Reference-Bootloader-Hikey#building-from-source) for instructions on how to built the boot loader from source.

#### How to get and customize Debian packages source code

This release is based on Debian 8.2 "Jessie".

Since all packages installed in Linaro Debian-based images are maintained either in Debian archives or in Linaro repositories, it is possible for users to update their environment with commands such as:

```shell
sudo apt-get update
sudo apt-get upgrade
```

All user space software is packaged using Debian packaging process. As such you can find extensive information about using, patching and building packages in The Debian New Maintainers Guide. If you quickly want to rebuild any package, you can run the following commands to fetch the package source code and install all build dependencies:

```shell
sudo apt-get update
sudo apt-get build-dep <pkg>
apt-get source <pkg>
```

Then you can rebuild the package locally with:

```shell
cd <pkg-version>
dpkg-buildpackage -b -us -uc
```

#### TODO

* Explain how to build the rootfs from source