# HiKey - UEFI

The following binaries are required:
* l-loader.bin - used to switch from aarch32 to aarch64 and boot
* fip.bin - firmware package
* ptable.img  - partition table
* kernel and dtb images - included in the boot partition

## Source code

The source code is available from:
* [l-loader](https://github.com/96boards/l-loader)
* [ARM Trusted Firmware](https://github.com/96boards/arm-trusted-firmware)
* [EDK II (UEFI)](https://github.com/96boards/edk2)

## Build instructions

Prerequisites:
* GCC 4.8 - cross-toolchain for Aarch64 available in your PATH. [Linaro GCC 4.8-2014.04](http://releases.linaro.org/14.04/components/toolchain/binaries/gcc-linaro-aarch64-linux-gnu-4.8-2014.04_linux.tar.xz) is used in the build instructions.
* GCC cross-toolchain for gnueabihf available in your PATH. [Linaro GCC 4.9-2014.09](http://releases.linaro.org/14.09/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux.tar.xz) is used in the build instructions.
* GPT fdisk (gdisk package from your favorite distribution).

### Install custom toolchain(s)

```shell
mkdir arm-tc arm64-tc
tar --strip-components=1 -C ${PWD}/arm-tc -xf gcc-linaro-arm-linux-gnueabihf-4.9-*_linux.tar.xz
tar --strip-components=1 -C ${PWD}/arm64-tc -xf gcc-linaro-aarch64-linux-gnu-4.8-*_linux.tar.xz
export PATH="${PWD}/arm-tc/bin:${PWD}/arm64-tc/bin:$PATH"
```

### Get the source code

```shell
git clone -b hikey --depth 1 https://github.com/96boards/edk2.git linaro-edk2
git clone -b hikey-v0.2.2 --depth 1 https://github.com/96boards/arm-trusted-firmware.git
git clone -b hikey-v0.2.2 --depth 1 https://github.com/96boards/l-loader.git
git clone git://git.linaro.org/uefi/uefi-tools.git
```

### Build UEFI for HiKey

```shell
export AARCH64_TOOLCHAIN=GCC48
export EDK2_DIR=${PWD}/linaro-edk2
export UEFI_TOOLS_DIR=${PWD}/uefi-tools

cd ${EDK2_DIR}
${UEFI_TOOLS_DIR}/uefi-build.sh -b RELEASE -a ../arm-trusted-firmware hikey

cd ../l-loader
ln -s ${EDK2_DIR}/Build/HiKey/RELEASE_GCC48/FV/bl1.bin
ln -s ${EDK2_DIR}/Build/HiKey/RELEASE_GCC48/FV/fip.bin
arm-linux-gnueabihf-gcc -c -o start.o start.S
arm-linux-gnueabihf-gcc -c -o debug.o debug.S
arm-linux-gnueabihf-ld -Bstatic -Tl-loader.lds -Ttext 0xf9800800 start.o debug.o -o loader
arm-linux-gnueabihf-objcopy -O binary loader temp
python gen_loader.py -o l-loader.bin --img_loader=temp --img_bl1=bl1.bin
# XXX sgdisk usage requires sudo
sudo bash -x generate_ptable.sh
python gen_loader.py -o ptable.img --img_prm_ptable=prm_ptable.img --img_sec_ptable=sec_ptable.img
```

The files fip.bin, l-loader.bin and ptable.img are now built.

### EFI boot partition (boot-fat.uefi.img)

The boot partition is a 64MB FAT partition and contains kernel/dtb files. It is assumed the kernel has been built. See Getting Started instructions for more information on building the kernel.

```shell
$ mkdir boot-fat
$ dd if=/dev/zero of=boot-fat.uefi.img bs=512 count=131072
$ sudo mkfs.fat -n "BOOT IMG" boot-fat.uefi.img
$ sudo mount -o loop,rw,sync boot-fat.uefi.img boot-fat
$ sudo cp -a path/to/Image path/to/hi6220-hikey.dtb path/to/initrd.img-* boot-fat/ || true
$ sudo umount boot-fat
$ rm -rf boot-fat
```

## Flash binaries to eMMC

The flashing process requires to be in **recovery mode**.

* turn off HiKey board
* connect debug UART on HiKey to PC (used to monitor debug status)
* make sure pin1-pin2 and pin3-pin4 on J15 are linked (recovery mode)
* connect USB cable to PC
* turn on HiKey board
* on serial console, you should see some debug message (NULL packet)
* run [HiKey recovery tool](https://raw.githubusercontent.com/96boards/burn-boot/master/hisi-idt.py) to flash l-loader.bin (Note: /dev/ttyUSB1 is not necessarily your device, check dmesg output to make sure to use the correct device and adjust the command line below as appropriate)
```shell
sudo python hisi-idt.py -d /dev/ttyUSB1 --img1=l-loader.bin
```
* run fastboot commands to flash the images (**order must be respected**)
```shell
$ wget https://builds.96boards.org/releases/hikey/nvme.img
$ sudo fastboot flash ptable ptable.img
$ sudo fastboot flash fastboot fip.bin
$ sudo fastboot flash nvme nvme.img
$ sudo fastboot flash boot boot-fat.uefi.img
```
* turn off HiKey board
* remove the jumper of pin3-pin4 on J15
* turn on HiKey board

## Known Issues

* [x] ~~mainline kernel fails to boot. 3.18 kernel boots.~~
* [x] ~~performance issues in ATF/UEFI: download/boot is slow.~~
* [x] ~~initrd isn't supported. We can only use initramfs at the moment.~~
* [ ] fastboot feature isn't enabled in UEFI. Recovery mode should be used to download images in ATF.
* [x] ~~only one core is supported. PSCI is being worked on.~~
* [ ] DDR works only at 533MHz.
* [ ] NVM isn't supported in UEFI.
* [ ] SD card isn't supported in UEFI.
* [ ] MCU image isn't loaded by ATF. As a result, we can't enable cpufreq.
* [x] ~~thermal feature isn't enabled in ATF.~~