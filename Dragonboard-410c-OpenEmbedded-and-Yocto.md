This wiki page provides instructions to get started with OpenEmbedded and the Yocto Project on the DragonBoard 410c. 

# Introduction

This wiki is not an introduction on OpenEmbedded or Yocto Project. If you are not familiar with OpenEmbedded and the Yocto Project, it is very much recommended to read the appropriate documentation first. For example, you can start with:
* http://openembedded.org/wiki/Main_Page
* http://yoctoproject.org/
* https://www.yoctoproject.org/documentation

In this wiki, we assume that the reader is familiar with basic concepts of OpenEmbedded.

The initial support for DragonBoard 410c has been committed in the [meta-qualcomm BSP layer](https://github.com/ndechesne/meta-qualcomm).

This layer has been tested with OpenEmbedded Core layer, and is expected to work with any other standard layers and of course any OpenEmbedded based distributions.

The Linux kernel used for the DragonBoard 410c is the Linaro Landing team kernel, e.g. the same kernel used for the Linaro Ubuntu-based builds. The graphic stack is based on mesa, using the freedreno driver.

# Status of DragonBoard 410c in the meta-qualcomm layer

* The kernel provided by the BSP layer is the same as the kernel in the 15.07 Ubuntu-based release
* This is a very first attempt at adding the DragonBoard 410c support, the following is supported:
 * Display (HDMI)
 * 4x A53 core running at 1.2Ghz
 * Audio (HDMI)
 * SD, eMMC, USB, GPIO, I2C
* Mesa in OE Core master branch is currently 10.5.8 and does not support A306 GPU, which was introduced in 10.6.3, if you want to use the GPU, you need this OE core [patch](http://lists.openembedded.org/pipermail/openembedded-core/2015-August/108299.html).
* For X11 we use xf86-video-freedreno driver, with XA enabled

# Setup the build environment

The Qualcomm BSP layer can be used with any OE based distribution, such as Poky. However for simplicity the following instructions do not use any distribution, and instead use the 'distro-less' OE Core. As such, the Qualcomm layer only depends on OE core (and of course bitbake). 

You need to download the following git trees:

    mkdir oe && cd oe
    git clone https://github.com/openembedded/oe-core openembedded-core
    git clone https://github.com/openembedded/bitbake openembedded-core/bitbake
    git clone https://github.com/ndechesne/meta-qualcomm.git

To initialize your build environment, you need to run:

    source openembedded-core/oe-init-build-env <build folder>

Now, you need to edit the file `<build>/conf/local.conf` and set

    MACHINE ?= "dragonboard-410c"

If you want your images to have a SSH server installed by default, you can to add `ssh-server-dropbear` to `CORE_IMAGE_EXTRA_IMAGE_FEATURES` in this configuration file.

These instructions can be used to generate a kernel image and a root file system that can be used on the DragonBoard 410c. You can refer to [[Dragonboard-410c-Boot-Image]] to learn how to use the generated files.

You now need to edit `<build>/conf/bblayers.conf`, and make sure that the variable `BBLAYERS` looks like this:

    BBLAYERS ?= " \
      ##OEROOT##/openembedded-core/meta \
      ##OEROOT##/meta-qualcomm \
      "

Where `##OEROOT##` should the the absolute path of your build environment.

# Build a minimal, console only image

To build a console image, you can run:

    bitbake core-image-minimal

At the end of the build, the root file system image will be available as `tmp-eglibc/deploy/images/dragonboard-410c/core-image-minimal-dragonboard-410c.tar.gz` The file system can be converted into a fastboot compatible image and flashed into eMMC.

Similarly, the kernel `Image` will be available at `tmp-eglibc/deploy/images/dragonboard-410c/Image`.

# Build a simple X11 image

To build an X11 image with GPU hardware accelerated support, you need to add the following to the `local.conf` configuration file:

    # to enable opengl feature
    DISTRO_FEATURES_append = " opengl"
    # to include mesa utils in the root fs, such as glxgears, glxinfo, ..
    CORE_IMAGE_EXTRA_INSTALL += "mesa-demos"
    # to prevent X server for starting automatically at boot, this is recommended for now
    VIRTUAL-RUNTIME_graphical_init_manager = ""

Then to build the image, you can run:

    bitbake core-image-x11

At the end of the build, the root file system image will be available as `tmp-eglibc/deploy/images/dragonboard-410c/core-image-x11-dragonboard-410c.tar.gz`.

By default, the required firmware are not installed in the image. The firmware need to be separately downloaded from [Qualcomm Developer Network](https://developer.qualcomm.com/download/linux-ubuntu-board-support-package-v1.zip). The firmware files need to be extracted in the root FS, in `/lib/firmware`.

Then you can finally start the X server, and run any graphical application:

    X&
    export DISPLAY=:0
    glxgears

The default X11 image does not include a window manager, you can easily add `metacity` or `openbox` in the image. `metacity` package is provided by the `meta-gnome` layer, in the `meta-openembedded` repository, while `openbox` is in the `meta-oe` layer. So let's first clone this new git tree:

    cd oe # e.g. the initial folder we created initially
    git clone https://github.com/openembedded/meta-openembedded

Then edit `<build>/conf/bblayers.conf`, and make sure that the variable `BBLAYERS` now looks like this:

    BBLAYERS ?= " \
      ##OEROOT##/openembedded-core/meta \
      ##OEROOT##/meta-qualcomm \
      ##OEROOT##/meta-openembedded/meta-oe \
      ##OEROOT##/meta-openembedded/meta-gnome \
      "

To install `metacity` in the image, add the following to `conf/local.conf` file:

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