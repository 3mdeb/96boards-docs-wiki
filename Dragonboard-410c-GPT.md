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
