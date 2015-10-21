
# How to create a kernel boot image for the DragonBoard 410c

The boot image that can be used with fastboot uses a specific format, and this document provides instructions to create such a boot file. The boot image generally contains the kernel image, an initrd image as well as a specific/custom device tree image.

NOTE: This section is for Ubuntu only! Android uses a different tree.

## Building the kernel

    git clone https://git.linaro.org/landing-teams/working/qualcomm/kernel.git
    cd kernel
    git checkout integration-linux-qcomlt
    export CROSS_COMPILE=aarch64-linux-gnu-
    export ARCH=arm64
    export PATH=<path to your ARM64 cross compiler>:$PATH
    make O=build-${ARCH} defconfig
    make O=build-${ARCH} -j4 Image dtbs

## Building the kernel modules (optional, only if you need them)
    make O=build-${ARCH} modules
    mkdir build-${ARCH}-modules
    make O=build-${ARCH} INSTALL_MOD_PATH=build-${ARCH}-modules modules_install
    tar -C build-${ARCH}-modules czf modules.tgz lib/modules
    # try below command if the above doesn't work
    tar czf modules.tgz build-${ARCH}/build-${ARCH}-modules/lib/modules
    # copy modules.tgz (using SCP or SD card) to the device, tar xvf in the /

## Getting the skales tools

Somewhere, on your machine, install the following tools:

    git clone git://codeaurora.org/quic/kernel/skales 

To use this tool you should have the _fdtget_ program. This is commonly distributed as part of the device tree compiler package.

    device-tree-compiler (debian)
    dtc (redhat)
    sys-apps/dtc (gentoo)


## Building the boot image

The boot image consists of the table of device tree, the kernel image and an init ramdisk image.

### Initialize the environment

In a terminal window that will be used for the entire section, please run:

    cd <kernel source tree>
    export PATH=<path of the skales tools>:$PATH
    export ARCH=arm64

### How to create dt.img

The _dtbTool_ is a standalone application that will process the DTBs generated during the kernel build, to create the table of device tree image, simply run:

    dtbTool -o dt.img -s 2048 build-${ARCH}/arch/arm64/boot/dts/qcom/

### Init ramdisk

To create the boot image, you need a ramdisk image. For now it is recommended to download one of the ramdisk image from Linaro builds.

    wget http://builds.96boards.org/snapshots/dragonboard410c/linaro/ubuntu/latest/initrd.img-*

### How to create the boot image

The tool _mkbootimg_ is a standalone application that will process all files and create the boot image that can then be booted on the target board, or flash into the on-board eMMC.

The boot image also contains the kernel bootargs, which can be changed as needed in the next command. If you want to mount the rootfs from the ramdisk, you can generate the boot image like this:

    export cmdline="root=/dev/ram0 rw rootwait console=ttyMSM0,115200n8"
    mkbootimg --kernel build-${ARCH}/arch/arm64/boot/Image \
              --ramdisk initrd.img-4.0.0-linaro-lt-qcom \
              --output boot-db410c.img \
              --dt dt.img \
              --pagesize 2048 \
              --base 0x80000000 \
              --cmdline "$cmdline"

If you have install a rootFS on the on-board eMMC, for example in the _userdata_ partition, you can use this instead:

    export cmdline="root=/dev/disk/by-partlabel/userdata rw rootwait console=ttyMSM0,115200n8"

For the text console add "text" to the end of cmdline:

    export cmdline="root=/dev/disk/by-partlabel/userdata rw rootwait console=ttyMSM0,115200n8 text"

# How to use the boot image

The boot image generated using the instructions from the section above can be booted using fastboot:

    sudo fastboot boot boot-db410c.img

Alternatively, it can be flashed into the on-board eMMC:

    sudo fastboot flash boot boot-db410c.img