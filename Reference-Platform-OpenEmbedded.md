This wiki page provides instructions to get started with OpenEmbedded and the Yocto Project using the 96boards OpenEmbedded Reference Software Platform.
 
# Introduction

This wiki is not an introduction on OpenEmbedded or Yocto Project. If you are not familiar with OpenEmbedded and the Yocto Project, it is very much recommended to read the appropriate documentation first. For example, you can start with:
* http://openembedded.org/wiki/Main_Page
* http://yoctoproject.org/
* https://www.yoctoproject.org/documentation

In this wiki, we assume that the reader is familiar with basic concepts of OpenEmbedded.

# What is the OpenEmbedded Reference Software Platform

TBD: add a not about supported machines,  distros and reference images

# Setup the build environment

To manage the various git trees and the OpenEmbedded environment, a repo manifest is provided. If you do not have `repo` installed on your host machine, you first need to install it, using the following instructions (or similar):

    mkdir -p ${HOME}/bin
    curl https://storage.googleapis.com/git-repo-downloads/repo > ${HOME}/bin/repo
    chmod a+x ${HOME}/bin/repo
    export PATH=${HOME}/bin:${PATH}

To initialize your build environment, you need to run:

    mkdir oe-rpb && cd oe-rpb
    repo init -u https://github.com/96boards/oe-rpb-manifest.git -b jethro
    repo sync
    source setup-environment [<build folder>]

* after the command `repo sync` returns, all the OpenEmbedded recipes have been downloaded locally.
* you will be prompted to choose the target machine, among the support machines
* you will be prompted to choose the distro, among the supported distro
* <build folder> is optional, if missing it will default to `build-$DISTRO`

The script `setup-environment` will create sane default configuration files in <build folder>/conf, you can inspect them and modify them if needed. Note that conf/local.conf and conf/bblayers.conf are symlink , and under source control. So it is generally better not to modify them, and use conf/site.conf and conf/auto.conf instead.

# Build a minimal, console-only image

To build a console image, you can run:

    $ bitbake rpb-console-image

At the end of the build, your build artifacts will be found in `tmp-eglibc/deploy/images/$MACHINE`.

# Build a simple X11 image

To build an X11 image:

    $ bitbake rpb-desktop-image

Then you can finally start the X server, and run any graphical application:

    X&
    export DISPLAY=:0
    glxgears

Or with the default window manager included in the X11 image includes:

    X&
    export DISPLAY=:0
    openbox &
    glxgears

# Build a sample Wayland/Weston image

For Wayland/weston, it is recommended to change the DISTRO and use `rpb-wayland` instead of `rpb`. The main reason is that in the `rpb-wayland` distro, the support for X11 is completely removed. So , in a new terminal prompt, setup a new environment and make sure to use `rpb-wayland` for DISTRO, then, you can run a sample image with:

    $ bitbake rpb-weston-image

If you boot this image on the board, you should get a command prompt on the HDMI monitor. A user called `linaro` exists (and has no password). Once logged in a VT, you run start weston with:

    weston-launch

And that should get you to the Weston desktop shell.
# Proprietary content

Some BSPs might require the user to read and accept a EULA (such as Qualcomm based development boards). When you select a MACHINE that has such a requirement, the EULA will be presented when running the `setup-environment` script. The EULA is typically required to access the proprietary firmware, such as the GPU firmware , WLAN, ... 

If you accepted the EULA, when building an image all proprietary firmware (or content) are installed automatically in the image, either in `/lib/firmware` or wherever it is appropriate, and a copy of the EULA is also installed in the image.

If you did not accept the EULA, the firmware are not downloaded, and not installed into the image. Of course some features will not work properly.

# Support

For general question or support request, please use this mailing list https://lists.linaro.org/mailman/listinfo/openembedded. 

For any bug related to this release, please submit issues to the [96Board.org Bug tracking system](https://bugs.96boards.org/).
