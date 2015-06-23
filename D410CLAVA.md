# Dragonboard 410C - LAVA

The following items are required:
* Dragonboard 410C - running LK bootloader
* Micro USB Cable - for flashing the board
* UART Adapter - for interacting with the board
* Software Controllable Power Switch  - for automatically power cycling the board
* Installed LAVA instance (2015.06+) - for automating software delivery and testing

## Board Setup

1. Enter Fastboot mode ([Section 2.2.4 "Bring the board into fastboot-mode"](https://github.com/96boards/documentation/blob/master/dragonboard410c/LinuxUserGuide_DragonBoard.pdf))
2. Erase 'boot' partition (fastboot erase boot)

## LAVA Configuration

* Install the image creation tools to the LAVA dispatcher. (As root)
  1. cd /opt
  2. git clone git://codeaurora.org/quic/kernel/skales
  3. **Note: If you want to boot upstream kernels as of 6/22/2015, you must apply a [patch](https://drive.google.com/a/linaro.org/file/d/0B9NXjOlmLD7QZ2J1U2s0MkVFT0hUVWFGNTd6cHRTaXBrZDdF/view?usp=sharing) to skales to workaround the msm-id and board-id detection [issue](http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/327857.html).

* Uniquely identify your fastboot serial number for the D410C
  1. fastboot devices
  2. 1f980087 fastboot
  3. Record 1f980087 or similar as you will need it later

* Create the device configuration
  1. Create a file /etc/lava-dispatcher/devices/apq8016-sbc01.conf
  2. **fastboot_command** is the shell command used to flash the board, use the usb id obtained from above
  3. **connection_command** is the shell command used to connect to the UART port
  4. **hard_reset_command** is the shell command to turn the board off and then on again
  5. **power_off_cmd** is the shell command to turn the board off

```
device_type = apq8016-sbc
fastboot_driver = apq8016-sbc
adb_command = adb -s 1f98008
fastboot_command = fastboot -s 1f980087
connection_command = telnet serial-server 2002
hard_reset_command = /bin/pdu.sh OFF 4; sleep 10; /bin/pdu.sh ON 4
power_off_cmd = /bin/pdu.sh OFF 4
mkbootimg_binary = /opt/qcom/skales/mkbootimg
dtbtool_binary = /opt/qcom/skales/dtbTool
```

 * Now you can add this device to the LAVA scheduler as documented [here](https://validation.linaro.org/static/docs/lava-image-creation.html#adding-to-the-scheduler)