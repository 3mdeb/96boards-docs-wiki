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
git clone -b hikey --depth 1 https://github.com/96boards/arm-trusted-firmware.git
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
$ sudo cp -a path/to/Image path/to/hi6220-hikey.dtb boot-fat/ || true
$ sudo cp -a path/to/initrd.img-* boot-fat/initrd.img || true
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
* run [HiKey recovery tool](https://raw.githubusercontent.com/96boards/burn-boot/master/hisi-idt.py) to flash l-loader.bin (Note: if the serial port recorded in hisi-idt.py isn't available, adjust the command line below by manually setting the serial port with "-d /dev/ttyUSBx" where x is usually the last serial port reported by "dmesg" command)
```shell
sudo python hisi-idt.py --img1=l-loader.bin
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


## fastboot from uefi

1. copy application
cp Build/HiKey/DEBUG_GCC48/AARCH64/AndroidFastbootApp.efi boot-fat/fastboot.efi

2. board usage
The default boot selection will start in  10 seconds
[3] Boot Manager
Start: 3
[1] Add Boot Device Entry
Choice: 1
[1] BOOT IMG (63 MB)
        - VenHw(B549F005-4BD4-4020-A0CB-06F42BDA68C3)/HD(6,GPT,5C0F213C-17E1-4149-88C8-8B50FB4EC70E,0x7000,0x20000)
        Select the Boot Device: 1
        File path of the EFI Application or the kernel: fastboot.efi
        Is your application an OS loader? [y/n] n
        Arguments to pass to the EFI Application:
        Description for this new Entry: f
[1] Add Boot Device Entry
[2] Update Boot Device Entry
[3] Remove Boot Device Entry
[4] Reorder Boot Device Entries
[5] Update FDT path
[6] Set Boot Timeout
[7] Return to main menu
Choice: 7
[1] Linux from eMMC
- VenHw(B549F005-4BD4-4020-A0CB-06F42BDA68C3)/HD(6,GPT,5C0F213C-17E1-4149-88C8-8B50FB4EC70E,0x7000,0x20000)/I
mage
- Initrd: VenHw(B549F005-4BD4-4020-A0CB-06F42BDA68C3)/HD(6,GPT,5C0F213C-17E1-4149-88C8-8B50FB4EC70E,0x7000,0x
                20000)/initrd.img
- Arguments: console=ttyAMA0,115200 earlycon=pl011,0xf8015000 root=/dev/mmcblk0p9 rw verbose debug user_debug
=31 loglevel=8
- LoaderType: Linux kernel with FDT support
[2] f
- VenHw(B549F005-4BD4-4020-A0CB-06F42BDA68C3)/HD(6,GPT,5C0F213C-17E1-4149-88C8-8B50FB4EC70E,0x7000,0x20000)/f
astboot.efi
- Arguments:
[3] Shell
[4] Boot Manager
Start: Invalid input (max 4)
Start: 2
add-symbol-file /home/zhangfei/work/96board/linaro-edk2/Build/HiKey/DEBUG_GCC48/AARCH64/EmbeddedPkg/Application/Andro
idFastboot/AndroidFastbootApp/DEBUG/AndroidFastbootApp.dll 0x3AA87260
Loading driver at 0x0003AA87000 EntryPoint=0x0003AA87260 AndroidFastbootApp.efi
Android Fastboot mode - version 0.4. Press any key to quit.

3. fastboot config in host
vi /etc/udev/rules.d/51-android.rules
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="d00d", MODE="0600", OWNER=""

4. host use:
fastboot flash fastboot fip.bin
fastboot flash nvme nvme.img
fastboot flash boot boot-fat.uefi.img
fastboot flash system system.img
fastboot flash cache cache.img
fastboot flash userdata userdata.img


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
* [ ] Hisilicon's boot loader (fastboot1.img/fastboot2.img) only supports spin-table to enable multiple CPUs, and ATF only supports PSCI to enable multiple CPUs. So if use psci's dtb and Hisilicon's boot loader, it will introduce the hang issue. Have two ways to workaround this issue: set "maxcpus=1" in command line, or change dtb from **enable-method = "psci"** to **enable-method = "spin-table"**.