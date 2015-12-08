# Abstract

Sometimes when using HDMI monitor it might be needed (or useful) to force a display resolution, and bypass the processing of the EDID.

# Method 1: Using DRM_LOAD_EDID_FIRMWARE

## Details

This is a Linux kernel feature that can be used:

    if you want to use EDID data to be loaded from the
    /lib/firmware directory or one of the provided built-in
    data sets. This may be necessary, if the graphics adapter or
    monitor are unable to provide appropriate EDID data. Since this
    feature is provided as a workaround for broken hardware, it is 
    disabled by default. 

Details and instructions how to build your own EDID data are given in [Documentation/EDID/HOWTO.txt](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/EDID/HOWTO.txt).

So basically, when using this feature the real EDID is not used, and is being replaced by a fake one.

By default, the kernel has the following prebuilt EDID:

    #define GENERIC_EDIDS 6
    static const char *generic_edid_name[GENERIC_EDIDS] = {
            "edid/800x600.bin",
            "edid/1024x768.bin",
            "edid/1280x1024.bin",
            "edid/1600x1200.bin",
            "edid/1680x1050.bin",
            "edid/1920x1080.bin",
    };

This structure is defined in the kernel, in [drivers/gpu/drm/drm_edid_load.c](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/drm_edid_load.c).

## How to boot with a custom EDID file?

In order to use this kernel feature, the following kernel config must be enabled:

    CONFIG_DRM_LOAD_EDID_FIRMWARE=y

Note: it is enabled by default on DragonBoard 410c Linux releases from [http://builds.96boards.org/releases/dragonboard410c/linaro/debian/](http://builds.96boards.org/releases/dragonboard410c/linaro/debian/).

The name of the custom EDID file needs to be given in the kernel boot arguments. 

If you are compiling and booting

"drm_kms_helper.edid_firmware=edid/1280x1024.bin"