# Dragonboard 410C - LAVA

The following items are required:
* Dragonboard 410C - running LK bootloader
* Micro USB Cable - for flashing the board
* UART Adapter - for interacting with the board
* Software Controllable Power Switch  - for automatically power cycling the board
* Installed LAVA instance (2015.06+) - for automating software delivery and testing

## Board Setup

1. Enter [Fastboot](https://github.com/96boards/documentation/blob/master/dragonboard410c/LinuxUserGuide_DragonBoard.pdf) mode (Section 2.2.4 "Bring the board into fastboot-mode")
2. Erase 'boot' partition (fastboot erase boot)