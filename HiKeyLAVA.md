# HiKey - LAVA

The following items are required:
* HiKey - running UEFI firmware
* Micro USB Cable - for flashing the board
* UART Adapter - for interacting with the board
* Software Controllable Power Switch  - for automatically power cycling the board
* Installed LAVA instance (2015.05+) - for automating software delivery and testing

## Board Setup

1. Install [UEFI](https://github.com/96boards/documentation/wiki/UEFI)
2. Flash the proper partition table for your use case, ptable-linux.img or ptable-android.img
3. Flash boot-fat.uefi.img.gz
4. Setup Fastboot
  1. Delete all existing boot entries
  2. Add boot entry for fastboot as described on the [UEFI](https://github.com/96boards/documentation/wiki/UEFI) page
  3. Confirm the newly created fastboot entry is the 1st option in the list
  4. Launch this option and verify a fastboot device is detected on your LAVA host

## LAVA Configuration

* Uniquely identify your fastboot usb id for HiKey
  1. fastboot devices -l
  2. ???????????? fastboot usb:3-12.4
  3. Record usb:3-12.4 or similar as you will need it later

* Create the device configuration
  1. Create a file /etc/lava-dispatcher/devices/hi6220-hikey01.conf
  2. **connection_command** is the shell command used to connect to the UART port
  3. **hard_reset_command** is the shell command to turn the board off and then on again
  4. **power_off_cmd** is the shell command to turn the board off
  5. Note that the as of 5/6/2015 the adb serial number is not unique, and will always be 0123456789

```
device_type = hi6220-hikey
fastboot_driver = hi6220_hikey
adb_command = adb -s 0123456789
fastboot_command = fastboot -s usb:3-12.4
connection_command = telnet serial-server 2002
hard_reset_command = /bin/pdu.sh OFF 4; sleep 10; /bin/pdu.sh ON 4
power_off_cmd = /bin/pdu.sh OFF 4
```

 * Now you can add this device to the LAVA scheduler as documented [here](https://validation.linaro.org/static/docs/lava-image-creation.html#adding-to-the-scheduler)

## LAVA Examples

  * Debian LAVA Job
```
{
    "actions": [
        {
            "command": "deploy_linaro_android_image",
            "parameters": {
                "images": [
                    {
                        "partition": "boot",
                        "url": "http://builds.96boards.org/snapshots/hikey/debian/287/boot-fat.uefi.img.gz"
                    },
                    {
                        "partition": "system",
                        "url": "http://builds.96boards.org/snapshots/hikey/debian/287/hikey-jessie_developer_20150505-287.emmc.img.gz"
                    }
                ],
                "target_type": "ubuntu"
            }
        },
        {
            "command": "boot_linaro_image"
        }
    ],
    "device_type": "hi6220-hikey",
    "job_name": "hi6220-hikey-debian-boot-test",
    "logging_level": "DEBUG",
    "timeout": 18000
}
```

* Android LAVA Job

```
{
    "actions": [
        {
            "command": "deploy_linaro_android_image",
            "parameters": {
                "images": [
                    {
                        "partition": "boot",
                        "url": "http://builds.96boards.org/snapshots/hikey/android/87/boot_fat.img"
                    },
                    {
                        "partition": "system",
                        "url": "http://builds.96boards.org/snapshots/hikey/android/87/system.img"
                    },
                    {
                        "partition": "cache",
                        "url": "http://builds.96boards.org/snapshots/hikey/android/87/cache.img"
                    },
                    {
                        "partition": "userdata",
                        "url": "http://builds.96boards.org/snapshots/hikey/android/87/userdata.img"
                    }
                ]
            }
        },
        {
            "command": "boot_linaro_android_image",
            "parameters": {
                "test_image_prompt": "shell@hikey"
            }
        }
    ],
    "device_type": "hi6220-hikey",
    "job_name": "hi6220-hikey-android-boot-test",
    "logging_level": "DEBUG",
    "timeout": 18000
}
```

* Ramdisk LAVA Job

```
{
    "actions": [
        {
            "command": "deploy_linaro_kernel",
            "parameters": {
                "dtb": "http://builds.96boards.org/snapshots/hikey/debian/287/hi6220-hikey.dtb",
                "kernel": "http://builds.96boards.org/snapshots/hikey/debian/287/Image",
                "ramdisk": "http://storage.kernelci.org/images/rootfs/buildroot/arm64/rootfs.cpio.gz"
            }
        },
        {
            "command": "boot_linaro_image"
        }
    ],
    "device_type": "hi6220-hikey",
    "job_name": "hi6220-hikey-kernel-boot-test",
    "logging_level": "DEBUG",
    "timeout": 18000
}
```

