# HiKey - UEFI

The following binaries are required:
* l-loader.bin - used to switch from aarch32 to aarch64 and boot
* fip.bin - firmware package
* ptable-aosp.img or ptable-linux.img - partition tables for respectively AOSP images or Linux images
* kernel and dtb images - included in the boot partition

## Install from prebuilt binaries

Latest UEFI build is published [here](http://builds.96boards.org/snapshots/hikey/linaro/uefi/latest). Download the following files:
* [l-loader.bin](http://builds.96boards.org/snapshots/hikey/linaro/uefi/latest/l-loader.bin)
* [fip.bin](http://builds.96boards.org/snapshots/hikey/linaro/uefi/latest/fip.bin)
* [ptable-linux.img](http://builds.96boards.org/snapshots/hikey/linaro/uefi/latest/ptable-linux.img)

Latest Debian based builds are published [here](https://builds.96boards.org/snapshots/hikey/linaro/debian/latest). You can pick a boot partition and an eMMC rootfs:
* [boot-fat.uefi.img.gz](http://builds.96boards.org/snapshots/hikey/linaro/debian/latest/boot-fat.uefi.img.gz)
* [hikey-jessie_developer_YYYYMMDD-XXX.emmc.img.gz](http://builds.96boards.org/snapshots/hikey/linaro/debian/305/hikey-jessie_developer_20150526-305.emmc.img.gz)

For example, to download the latest UEFI build and Debian build 305 so:

```shell
wget https://builds.96boards.org/snapshots/hikey/linaro/uefi/latest/l-loader.bin
wget https://builds.96boards.org/snapshots/hikey/linaro/uefi/latest/fip.bin
wget https://builds.96boards.org/snapshots/hikey/linaro/uefi/latest/ptable-linux.img
wget https://builds.96boards.org/snapshots/hikey/linaro/debian/latest/boot-fat.uefi.img.gz
wget https://builds.96boards.org/snapshots/hikey/linaro/debian/305/hikey-jessie_developer_20150526-305.emmc.img.gz
gunzip *.img.gz
```
Now skip to the [Flash binaries to eMMC](#flash-emmc) section.

## Source code

The source code is available from:
* [l-loader](https://github.com/96boards/l-loader)
* [ARM Trusted Firmware](https://github.com/96boards/arm-trusted-firmware)
* [EDK II (UEFI)](https://github.com/96boards/edk2)
* (Optional) [OP-TEE] (https://github.com/OP-TEE/optee_os)

## Build instructions

Prerequisites:
* GCC 4.8 or 4.9 - cross-toolchain for Aarch64 available in your PATH. [Linaro GCC 4.9-2015.02](http://releases.linaro.org/15.02/components/toolchain/binaries/aarch64-linux-gnu/gcc-linaro-4.9-2015.02-3-x86_64_aarch64-linux-gnu.tar.xz) is used in the build instructions.
* GCC cross-toolchain for gnueabihf available in your PATH. [Linaro GCC 4.9-2015.02](http://releases.linaro.org/15.02/components/toolchain/binaries/arm-linux-gnueabihf/gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf.tar.xz) is used in the build instructions.
* GPT fdisk (gdisk package from your favorite distribution).

### Install custom toolchain(s)

```shell
mkdir arm-tc arm64-tc
tar --strip-components=1 -C ${PWD}/arm-tc -xf gcc-linaro-arm-linux-gnueabihf-4.9-*_linux.tar.xz
tar --strip-components=1 -C ${PWD}/arm64-tc -xf gcc-linaro-aarch64-linux-gnu-4.9-*_linux.tar.xz
export PATH="${PWD}/arm-tc/bin:${PWD}/arm64-tc/bin:$PATH"
```

### Get the source code

```shell
git clone -b hikey --depth 1 https://github.com/96boards/edk2.git linaro-edk2
git clone -b hikey --depth 1 https://github.com/96boards/arm-trusted-firmware.git
git clone --depth 1 https://github.com/96boards/l-loader.git
git clone git://git.linaro.org/uefi/uefi-tools.git

# Optionally, if also building OP-TEE
git clone --depth 1 https://github.com/OP-TEE/optee_os.git
```

### Build UEFI for HiKey

```shell
export AARCH64_TOOLCHAIN=GCC49
export EDK2_DIR=${PWD}/linaro-edk2
export UEFI_TOOLS_DIR=${PWD}/uefi-tools

cd ${EDK2_DIR}
${UEFI_TOOLS_DIR}/uefi-build.sh -b RELEASE -a ../arm-trusted-firmware hikey

# NOTE: If also building optional OP-TEE, run below command instead of the one above
# ${UEFI_TOOLS_DIR}/uefi-build.sh -b RELEASE -a ../arm-trusted-firmware -s ../optee_os hikey

cd ../l-loader
ln -s ${EDK2_DIR}/Build/HiKey/RELEASE_GCC49/FV/bl1.bin
ln -s ${EDK2_DIR}/Build/HiKey/RELEASE_GCC49/FV/fip.bin
arm-linux-gnueabihf-gcc -c -o start.o start.S
arm-linux-gnueabihf-gcc -c -o debug.o debug.S
arm-linux-gnueabihf-ld -Bstatic -Tl-loader.lds -Ttext 0xf9800800 start.o debug.o -o loader
arm-linux-gnueabihf-objcopy -O binary loader temp
python gen_loader.py -o l-loader.bin --img_loader=temp --img_bl1=bl1.bin
# XXX sgdisk usage requires sudo
sudo PTABLE=linux bash -x generate_ptable.sh
python gen_loader.py -o ptable-linux.img --img_prm_ptable=prm_ptable.img
```

The files fip.bin, l-loader.bin and ptable-linux.img are now built. All the image files are in $BUILD/l-loader directory. The Fastboot App is at adk2/Build/HiKey/RELEASE_GCC49/AARCH64/AndroidFastbootApp.efi

### EFI boot partition (boot-fat.uefi.img)

The boot partition is a 64MB FAT partition and contains kernel/dtb files. It is assumed the kernel has been built. See Getting Started instructions for more information on building the kernel.

```shell
$ mkdir boot-fat
$ dd if=/dev/zero of=boot-fat.uefi.img bs=512 count=131072
$ sudo mkfs.fat -n "BOOT IMG" boot-fat.uefi.img
$ sudo mount -o loop,rw,sync boot-fat.uefi.img boot-fat
$ sudo cp -a path/to/Image path/to/hi6220-hikey.dtb boot-fat/ || true
$ sudo cp -a path/to/initrd.img-* boot-fat/initrd.img || true
$ sudo cp path/to/AndroidFastbootApp.efi boot-fat/fastboot.efi
$ sudo umount boot-fat
$ rm -rf boot-fat
```

## Flash binaries to eMMC <a name="flash-emmc"></a>

The flashing process requires to be in **recovery mode** if user wants to update l-loader.bin.

* turn off HiKey board
* connect debug UART on HiKey to PC (used to monitor debug status)
* make sure pin1-pin2 and pin3-pin4 on J15 are linked (recovery mode)
* connect HiKey Micro-USB to PC with USB cable
* turn on HiKey board
* on serial console, you should see some debug message (NULL packet)
* run [HiKey recovery tool](https://raw.githubusercontent.com/96boards/burn-boot/master/hisi-idt.py) to flash l-loader.bin (Note: if the serial port recorded in hisi-idt.py isn't available, adjust the command line below by manually setting the serial port with "-d /dev/ttyUSBx" where x is usually the last serial port reported by "dmesg" command)
```shell
$ sudo python hisi-idt.py --img1=l-loader.bin
```

**do not reboot yet**
* run fastboot commands to flash the images (**order must be respected**)
```shell
$ wget https://builds.96boards.org/releases/hikey/linaro/binaries/latest/nvme.img
$ sudo fastboot flash ptable ptable-linux.img
$ sudo fastboot flash fastboot fip.bin
$ sudo fastboot flash nvme nvme.img
$ sudo fastboot flash boot boot-fat.uefi.img
$ sudo fastboot flash system hikey-jessie_alip_2015MMDD-nnn.emmc.img
```
* turn off HiKey board
* remove the jumper of pin3-pin4 on J15
* turn on HiKey board

## Run Fastboot from UEFI
* make sure that jumper of pin5-pin6 on J15 are connected

* Or Interrupt the boot by pressing any select
```shell
[2] Shell
```
* At the "Shell>" prompt, type: fastboot
```shell
Shell> fastboot
Android Fastboot mode - version 0.4. Press any key to quit
```
* fastboot configuration in host  
```shell
sudo apt-get install android-tools-fastboot
```
* host use:  
```shell
$ sudo fastboot flash ptable ptable-linux.img
$ sudo fastboot flash fastboot fip.bin  
$ sudo fastboot flash nvme nvme.img  
$ sudo fastboot flash boot boot-fat.uefi.img  
$ sudo fastboot flash system system.img  
$ sudo fastboot flash cache cache.img  
$ sudo fastboot flash userdata userdata.img  
# l-loader.bin should be flashed in recovery mode only

```
* Run Fastboot automatically:
```shell
Connect jumper on pin5-6 of J15. Then UEFI will run Fastboot app directly.
If user input "enter" key directly, bootmenu will be displayed.

```
* Control Auto Boot
```shell
By default, auto boot feature is enabled.

Command to disable auto boot:
$sudo fastboot oem autoboot 0
Command to enable auto boot:
$sudo fastboot oem autoboot 1

```
* Control Boot Order
```shell
If auto boot feature is enabled, a predefined boot entry will be selected
by default.

Boot entries:
1 -- Android Fastboot App
2 -- grub on eMMC
3 -- grub on SD

By default, the predefined boot entry is 2. If jumper on pin5-6 of J15 is
connect, the predefined boot entry is 1.

Command to change boot order for the case jumper not on pin5-6:
$sudo fastboot oem bootdevice [emmc|sd]

```
* Optional: To add fastboot to boot menu by manual:
```shell
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
VenHw(B549F005-4BD4-4020-A0CB-06F42BDA68C3)/HD(6,GPT,5C0F213C-17E1-4149-88C8-8B50FB4EC70E,0x7000,0x20000)/Image  
Initrd: VenHw(B549F005-4BD4-4020-A0CB-06F42BDA68C3)/HD(6,GPT,5C0F213C-17E1-4149-88C8-8B50FB4EC70E,0x7000,0x20000)/initrd.img  
Arguments: console=ttyAMA0,115200 earlycon=pl011,0xf8015000 root=/dev/mmcblk0p9 rw verbose debug user_debug=31 loglevel=8  
LoaderType: Linux kernel with FDT support  
[2] f  
VenHw(B549F005-4BD4-4020-A0CB-06F42BDA68C3)/HD(6,GPT,5C0F213C-17E1-4149-88C8-8B50FB4EC70E,0x7000,0x20000)/fastboot.efi  
Arguments:  
[3] Shell  
[4] Boot Manager  
Start: 2  
add-symbol-file /home/zhangfei/work/96board/linaro-edk2/Build/HiKey/DEBUG_GCC48/AARCH64/EmbeddedPkg/Application/Andro
idFastboot/AndroidFastbootApp/DEBUG/AndroidFastbootApp.dll 0x3AA87260
Loading driver at 0x0003AA87000 EntryPoint=0x0003AA87260 AndroidFastbootApp.efi
Android Fastboot mode - version 0.4. Press any key to quit.  

Note: fastboot.efi is renamed from $BUILD/linaro-edk2/Build/HiKey/RELEASE_GCC48/AARCH64/EmbeddedPkg/Application/AndroidFastboot/AndroidFastbootApp/OUTPUT/AndroidFastbootApp.efi
```

## Generate Random Serial Number in recovery mode

* Generate new serial number
```shell
$sudo fastboot oem serialno
```
By default, random serial number is generated in recovery mode. If user wants to generate new serial number, run the above command when hikey is in recovery mode. Then power off. In the next time, fastboot will use the new generated serial number for transmission.


## Known Issues

* [ ] Hisilicon's boot loader (fastboot1.img/fastboot2.img) only supports spin-table to enable multiple CPUs, and ATF only supports PSCI to enable multiple CPUs. So if use psci's dtb and Hisilicon's boot loader, it will introduce the hang issue. Have two ways to workaround this issue: set "maxcpus=1" in command line, or change dtb from **enable-method = "psci"** to **enable-method = "spin-table"**; "hisi,boardid = \<0 0 4 3\>;" should also be included in devicetree, otherwise the dtb cannot be loaded; at the same time, you also need to add "clock-frequency = \<1200000\>;" to the timer node in dts, it's a bug of old hisilicon bootloader but you must add it now when using the old one.
* [ ] flashing l-loader.bin to the pseudopartitions is not enabled