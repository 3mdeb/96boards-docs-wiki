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

# Setup the build environment

The Qualcomm BSP layer can be used with any OE based distribution, such as Poky. However for simplicity the following instructions do not use any distribution, and instead use the 'distro-less' OE Core. As such, the Qualcomm layer only depends on OE core (and of course bitbake). 

You need to download the following git trees:

    mkdir oe && cd oe
    git clone git://github.com/openembedded/oe-core openembedded-core
    git clone git://github.com/openembedded/bitbake openembedded-core/bitbake
    git clone http://github.com/ndechesne/meta-qualcomm.git

To initialize your build environment, you need to run:

    source openembedded-core/oe-init-build-env <build folder>

Now, you need to edit the file `<build>/conf/local.conf` and set

    MACHINE ?= "dragonboard-410c"

If you want your images to have a SSH server installed by default, you can to add `ssh-server-dropbear` to `EXTRA_IMAGE_FEATURES` in this configuration file.

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
# Support