This page provides information to create a custom GPT for DragonBoard 410c. Note that flashing your own GPT will result in loss of data on the eMMC, make sure that you know what you are doing.

The following tool can be used to:
* create a SD card image
* create GPT file to be used with fastboot to flash GPT (e.g. gpt_both0.bin)

# Create a bootable SD card

# Create gpt_both0.bin

gpt_both0.bin is a special format file for GPT that can be used with fastboot on Dragonboard, such as:

    fastboot flash partition gpt_both0.bin

When such command is executed, the GPT will be reflashed on the target, and it is very likely that all data on the eMMC is lost, and all firmware need to be reflashed.

To create gpt_both0.bin, you can run:

    git clone https://git.linaro.org/people/nicolas.dechesne/db-boot-tools.git
    # to create an empty image (sd.img) with the partition table from linux.txt
    sudo ./mksdcard.sh -g -o sd.img -p dragonboard410c/linux.txt
    # create a gpt backup
    sudo sgdisk -bgpt.bin sd.img
    # convert gpt backup into proper 'fastboot' format
    ./mkgpt.sh -i gpt.bin -o gpt_both0.bin

If you want to customize the partition table, you need to edit the file dragonboard410c/linux.txt. You can add partition as needed, change partition sizes, but you should not change the partition UID for the existing partitions that contain the bootloader and firmware, or you might brick your board.

If you want to add a few regular partitions, for example to install two Debian releases, you can do something like this:

    --- a/dragonboard410c/linux.txt
    +++ b/dragonboard410c/linux.txt
    @@ -6,4 +6,6 @@ hyp,512,E1A6A689-0C8D-4CC6-B4E8-55A4320FBD8A,hyp.mbn
     sec,16,303E6AC3-AF15-4C54-9E9B-D9A8FBECF401,sec.dat
     aboot,1024,400FFDCD-22E0-47E7-9A23-F16ED9382388,emmc_appsboot.mbn
     boot,65536,20117F86-E985-4357-B9EE-374BC1D8487D,
    +oe,786432
    +sid,2621440
     rootfs,0
