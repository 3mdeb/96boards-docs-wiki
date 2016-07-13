This page has instructions to get started with Debian or OpenEmbedded on the DragonBoard 820c board.

# Bootloaders

Throughout these instructions, we are assuming that you have been able to flash the board with an initial build from Qualcomm such that you can boot the board into fastboot. If you cannot get the board to boot into fastboot, then you need to get in touch with the person that provided you with the board.

# Onboard storage

The onboard storage is partionned such as : 

* `/dev/sda9` is `userdata` and is ~24GB
* `/dev/sde18` is `system` and is ~3GB
* `/dev/sde17` is `boot`

For now there is no rescue tool which is provided, so it is not recommended to change the partition layout. The root file system can be installed in `userdata` or `system` based on how much space is needed. It is even possible to install a Debian image in `userdata` and an OpenEmbedded image in `system` partition.

# Installing Debian

The DB820c is supported starting with build #8 from : http://snapshots.linaro.org/debian/pre-built/snapdragon-tracking-arm64/. Build #8 is based on 4.6 kernel, and has minimal features set (mostly console, UFS, 4 core running at the lowest speed). Features will be added in this builds stream. While build #8 is based on 4.6 kernel, next builds will switch to 4.7 and so on, until we reach the next LTS kernel version.

To install the Debian root file system:

1. Download either the `developer` or the `alip` image from the link above
1. Uncompress the root file system image
1. Flash the image into `userdata` (or `system`).

So, assuming you are using build #8:

    wget http://snapshots.linaro.org/debian/pre-built/snapdragon-tracking-arm64/8/linaro-jessie-developer-qcom-snapdragon-arm64-20160706-8.img.gz
    gunzip linaro-jessie-developer-qcom-snapdragon-arm64-20160706-8.img.gz
    fastboot flash userdata linaro-jessie-developer-qcom-snapdragon-arm64-20160706-8.img

You can download the prebuilt boot image as well, from the same location. However note that the boot image is by default going to try to mount the file system on `rootfs` partition, like on DragonBoard 410c, so you need to update the boot image before flashing it, since we do not (yet) use the `rootfs` partition on DB820c:

    wget http://snapshots.linaro.org/debian/pre-built/snapdragon-tracking-arm64/8/boot-linaro-jessie-qcom-snapdragon-arm64-20160706-8.img.gz
    gunzip boot-linaro-jessie-qcom-snapdragon-arm64-20160706-8.img.gz
    abootimg -u boot-linaro-jessie-qcom-snapdragon-arm64-20160706-8.img -c "cmdline=root=/dev/disk/by-partlabel/userdata rw rootwait console=tty0 console=ttyMSM0,115200n8"

You might need to replace `userdata` with `system`, of course.

# Installing an Open Embedded based image

TBD
