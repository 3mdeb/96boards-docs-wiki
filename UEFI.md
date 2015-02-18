# HiKey - UEFI

The following binaries are required:
* l-loader.bin - used to switch from aarch32 to aarch64 and boot
* fip.bin - firmware package
* ptable.img  - partition table

## Source code

The source code is available from:
* [l-loader](https://github.com/96boards/l-loader)
* [ARM Trusted Firmware](https://github.com/96boards/arm-trusted-firmware)
* [EDK II (UEFI)](https://github.com/96boards/edk2)

## Build instructions

### EDK II

Prerequisite: [GCC 4.9 - bare metal](http://releases.linaro.org/14.09/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.9-2014.09_linux.tar.xz) available in your PATH.
```shell
$ git clone --depth 1 -b hikey-v0.2.2 https://github.com/96boards/edk2.git
$ cd edk2
$ #export CROSS_COMPILE=/path/to/gcc-linaro-aarch64-none-elf-4.9-2014.07_linux/bin/aarch64-none-elf-
$ export EDK2_ARCH=AARCH64
$ export EDK2_TOOLCHAIN=GCC49
$ export GCC49_AARCH64_PREFIX=/path/to/gcc-linaro-aarch64-none-elf-4.9-2014.07_linux/bin/aarch64-none-elf-
$ make -f HisiPkg/LcbPkg/Makefile
$ aarch64-linux-gnu-objdump -b binary -maarch64 -D Build/Lcb/DEBUG_GCC49/FV/BL33_AP_UEFI.fd > bl33.dump
```
### ARM Trusted Firmware

Prerequisite: bl33.bin built from EDK II
```shell
$ git clone --depth 1 -b hikey-v0.2.2 https://github.com/96boards/arm-trusted-firmware.git
$ cd arm-trusted-firmware
$ make PLAT=lcb
```
### l-loader

Prerequisite: bl1.bin and fip.bin built from ARM Trusted Firmware
```shell
$ git clone --depth 1 -b hikey-v0.2.2 https://github.com/96boards/l-loader.git
$ cd l-loader
$ make
```
### EFI boot partition (efi.img)

efi.img file is a 64MB FAT partition and contains kernel/dtb files.
```shell
$ mkdir boot-fat
$ dd if=/dev/zero of=efi.img bs=512 count=131072
$ sudo mkfs.fat -n "BOOT IMG" efi.img
$ sudo mount -o loop,rw,sync efi.img boot-fat
$ sudo cp -a path/to/Image boot-fat/Image
$ sudo cp -a path/to/hi6220-hikey.dtb boot-fat/lcb.dtb
$ sudo cp -a path/to/initrd.img-* boot-fat/ramdisk.img
$ sudo umount boot-fat
$ rm -rf boot-fat
```
## Flash binaries to eMMC

The flashing process requires to be in recovery mode.

* turn off HiKey board
* connect debug UART on HiKey to PC (used to monitor debug status)
* make sure pin1-pin2 and pin3-pin4 on J15 are linked (recovery mode)
* connect USB cable to PC
* turn on HiKey board
* on serial console, you should see some debug message (NULL packet)
* run fastboot commands to download the images (order must be respected)
```shell
$ sudo fastboot flash ptable ptable.img
$ sudo fastboot flash fastboot fip.bin
$ sudo fastboot flash boot efi.img
```
* turn off HiKey board
* remove the jumper of pin3-pin4 on J15
* turn on HiKey board

## Known Issues

* mainline kernel fails to boot. 3.18 kernel boots.
* performance issues in ATF/UEFI: download/boot is slow.
* initrd isn't supported. We can only use initramfs at the moment.
* fastboot feature isn't enabled in UEFI. Recovery mode should be used to download images in ATF.
* only one core is supported. PSCI is being worked on.
* DDR works only at 533MHz.
* NVM isn't supported in UEFI.
* SD card isn't supported in UEFI.
* MCU image isn't loaded by ATF. As a result, we can't enable cpufreq.
* thermal feature isn't enabled in ATF.
