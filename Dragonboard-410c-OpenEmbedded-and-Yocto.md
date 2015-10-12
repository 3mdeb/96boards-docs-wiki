This wiki page provides instructions to get started with OpenEmbedded and the Yocto Project on the DragonBoard 410c. 

# Introduction

This wiki is not an introduction on OpenEmbedded or Yocto Project. If you are not familiar with OpenEmbedded and the Yocto Project, it is very much recommended to read the appropriate documentation first. For example, you can start with:
* http://openembedded.org/wiki/Main_Page
* http://yoctoproject.org/
* https://www.yoctoproject.org/documentation

In this wiki, we assume that the reader is familiar with basic concepts of OpenEmbedded.

The initial support for DragonBoard 410c has been committed in the [meta-qualcomm BSP layer](https://github.com/ndechesne/meta-qualcomm).

This layer has been tested with OpenEmbedded Core layer, and is expected to work with any other standard layers and of course any OpenEmbedded based distributions.

The Linux kernel used for the DragonBoard 410c is the Linaro Landing team kernel, e.g. the same kernel used for the Linaro Linux builds. The graphic stack is based on mesa, using the freedreno driver.

# Status of DragonBoard 410c in the meta-qualcomm layer

* The kernel provided by the BSP layer is the same as the kernel in the [latest Ubuntu-based release]( http://builds.96boards.org/releases/dragonboard410c/linaro/ubuntu/latest/)
* For X11 we use xf86-video-freedreno driver, with XA enabled
* Wayland/Weston is also tested, and working.

# Setup the build environment

The Qualcomm BSP layer can be used with any OE based distribution, such as Poky. However for simplicity the following instructions do not use any distribution, and instead use the 'distro-less' OE Core. As such, the Qualcomm layer only depends on OE core (and of course bitbake). 

To manage the various git trees and the OpenEmbedded environment, a repo manifest is provided. 

To initialize your build environment, you need to run:

    mkdir oe-qcom && cd oe-qcom
    repo init -u https://github.com/ndechesne/qcom-oe-manifest.git -b jethro
    repo sync
    source setup-environment [<build folder>]

* after the command `repo sync` returns all the OpenEmbedded recipes have been downloaded locally.
* you will be prompted to choose the target machine, pick `dragonboard-410c`
* <build folder> is optional, if missing it will default to `build-$MACHINE`

The script `setup-environment` will create sane default configuration files in <build folder>/conf, you can inspect them and modify them if needed.

# Bootloaders and eMMC partitions

The BSP layer assumes that the Linux Bootloaders and eMMC partition layout are used on the DragonBoard 410c (not the Android ones). You can download the latest Linux bootloader package from [here](http://builds.96boards.org/releases/dragonboard410c/linaro/rescue/latest/). If you use this partition layout, the eMMC has the following partition:

* `/dev/mmcblk0p7` , aka `aboot` is used for the bootloader (LK/fastboot)
* `/dev/mmcblk0p8` , aka `boot` is used for the boot image (kernel, device tree, initrd)
* `/dev/mmcblk0p10` , aka `rootfs` is used for the root file system
 
# Build a minimal, console only image

To build a console image, you can run:

    bitbake core-image-minimal

At the end of the build, the root file system image will be available as `tmp-eglibc/deploy/images/dragonboard-410c/core-image-minimal-dragonboard-410c.ext4.gz`. This file , once uncompressed, can be directly flashed into the `rootfs` partition.

Similarly, the boot image will be available at `tmp-eglibc/deploy/images/dragonboard-410c/boot-dragonboard-410c.img`, and it can be booted (or flashed) with fastboot.

# Firmware

By default, the required firmware are not installed in the image. The firmware need to be separately downloaded from [Qualcomm Developer Network](https://developer.qualcomm.com/download/linux-ubuntu-board-support-package-v1.1.zip). The firmware files need to be extracted in the root FS, in `/lib/firmware`.

# Build a sample Wayland/Weston image

OpenEmbedded comes with a basic Wayland/Weston image, but it has a few issues, and it is for now recommended to use the sample image included in the Qualcomm BSP layer:

    bitbake weston-image

This image includes a few additional features, such as `systemd`, `connman` which makes it simpler to use. Once built, the image will be available at `tmp-eglibc/deploy/images/dragonboard-410c/weston-image-dragonboard-410c.ext4.gz`. And it can be flashed into `rootfs` partition.

If you boot this image on the board, you should get a command prompt on the HDMI monitor. A user called `linaro` exists (and has no password). once logged in a VT, you run start weston with:

    weston-launch

And that should get you to the Weston desktop shell.

# Build a simple X11 image

To build an X11 image with GPU hardware accelerated support, you need to modify the `local.conf` configuration file. It is by default set to work for wayland. In `conf/local.conf`, locate the following lines:

    # default to using Wayland, if you need to make an X11 image, comment or delete the next 2 lines
    DISTRO_FEATURES_append = " wayland"
    DISTRO_FEATURES_remove = " x11"

and comment them out.

Then to build the image, you can run:

    bitbake core-image-x11

At the end of the build, the root file system image will be available as `tmp-eglibc/deploy/images/dragonboard-410c/core-image-x11-dragonboard-410c.ext4.gz`.

Then you can finally start the X server, and run any graphical application:

    X&
    export DISPLAY=:0
    glxgears

The default X11 image does not include a window manager, you can easily add `metacity` or `openbox` in the image. To install `metacity` in the image, add the following to `conf/local.conf` file:

    CORE_IMAGE_EXTRA_INSTALL += "metacity"

and rebuild the `core-image-x11` image, it will now include `metacity`, which can be started like this:

    X&
    export DISPLAY=:0
    metacity&
    glxgears

Similarly, you can replace `metacity` above with `openbox`.

# Support

For general question or support request, please go to [96boards.org Community forum](https://www.96boards.org/forums/forum/products/dragonboard410c/).

For any bug related to this release, please submit issues to the [96Board.org Bug tracking system](https://bugs.96boards.org/). To submit a bug, follow this [link](https://bugs.96boards.org/enter_bug.cgi?product=Dragonboard%20410c).