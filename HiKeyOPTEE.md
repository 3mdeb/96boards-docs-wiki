# HiKey - OP-TEE

How to integrate OP-TEE into your HiKey Linux image

## Build instructions

Prerequisites:
* GCC 4.9 - cross-toolchain for Aarch64 available in your PATH. [Linaro GCC 4.9-2015.05](http://releases.linaro.org/15.05/components/toolchain/binaries/aarch64-linux-gnu/gcc-linaro-4.9-2015.05-x86_64_aarch64-linux-gnu.tar.xz) is used in the build instructions.
* GCC cross-toolchain for gnueabihf available in your PATH. [Linaro GCC 4.9-2015.05](http://releases.linaro.org/15.05/components/toolchain/binaries/arm-linux-gnueabihf/gcc-linaro-4.9-2015.05-x86_64_arm-linux-gnueabihf.tar.xz) is used in the build instructions.

### Install custom toolchain(s)

```
mkdir arm-tc arm64-tc
tar --strip-components=1 -C ${PWD}/arm-tc -xf gcc-linaro-arm-linux-gnueabihf-4.9-*_linux.tar.xz
tar --strip-components=1 -C ${PWD}/arm64-tc -xf gcc-linaro-aarch64-linux-gnu-4.9-*_linux.tar.xz
export PATH="${PWD}/arm-tc/bin:${PWD}/arm64-tc/bin:$PATH"
```

### Build the kernel <a name="build-kernel"></a>

```
git clone https://github.com/96boards/linux.git
git checkout hikey

export LINUX_DIR=${PWD}/linux
export LOCALVERSION="-linaro-hikey"

cd ${LINUX_DIR}
make distclean 
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig 
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8 Image modules hi6220-hikey.dtb
cd ..
```

### Build the OP-TEE Linux kernel driver <a name="optee-driver"></a>

**NOTE:** Make sure you complete the [previous](#build-kernel) section, i.e. build the kernel, first!

```
git clone https://github.com/OP-TEE/optee_linuxdriver.git

export OPTEE_LINUXDRIVER_DIR=${PWD}/optee_linuxdriver

cd ${LINUX_DIR}
export LOCALVERSION="-linaro-hikey"
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- M=${OPTEE_LINUXDRIVER_DIR} clean modules
cd ..
```

The following files are now built:
* optee_linuxdriver/core/optee.ko
* optee_linuxdriver/armtz/optee_armtz.ko

### Build UEFI for HiKey <a name="uefi-hikey"></a>
```
git clone -b hikey --depth 1 https://github.com/96boards/edk2.git linaro-edk2
git clone -b hikey --depth 1 https://github.com/96boards/arm-trusted-firmware.git
git clone git://git.linaro.org/uefi/uefi-tools.git
git clone --depth 1 https://github.com/OP-TEE/optee_os.git

export AARCH64_TOOLCHAIN=GCC49
export EDK2_DIR=${PWD}/linaro-edk2
export UEFI_TOOLS_DIR=${PWD}/uefi-tools
export OPTEE_OS_DIR=${PWD}/optee_os

cd ${EDK2_DIR}
${UEFI_TOOLS_DIR}/uefi-build.sh -b RELEASE -a ../arm-trusted-firmware -s ../optee_os hikey
cd ..
```

The following file is now built:
* arm-trusted-firmware/build/hikey/release/fip.bin

### Build the OP-TEE client <a name="optee-client"></a>
```
git clone https://github.com/OP-TEE/optee_client.git

export OPTEE_CLIENT_DIR=${PWD}/optee_client

cd ${OPTEE_CLIENT_DIR}
make CROSS_COMPILE=aarch64-linux-gnu- clean all
cd ..
```

The following files are now built:
* optee_client/out/export/bin/tee-supplicant
* optee_client/out/export/lib/libteec.so.1.0

### Build the OP-TEE test suite <a name="optee-test"></a>

**NOTE:** Make sure you complete the [Build UEFI for HiKey](#uefi-hikey) section first!

```
git clone https://github.com/OP-TEE/optee_test.git

export OPTEE_TEST_DIR=${PWD}/optee_test

cd ${OPTEE_TEST_DIR}
make CROSS_COMPILE_HOST=aarch64-linux-gnu- CROSS_COMPILE_TA=arm-linux-gnueabihf- TA_DEV_KIT_DIR=${OPTEE_OS_DIR}/out/arm-plat-hikey/export-user_ta CFG_DEV_PATH=${PWD}/.. O=${OPTEE_TEST_DIR}/out clean all
cd ..
```

The following files are now built:
* optee_test/out/xtest/xtest
* optee_test/out/ta/sims/e6a33ed4-562b-463a-bb7eff5e15a493c8.ta
* optee_test/out/ta/os_test/5b9e0e40-2636-11e1-ad9e0002a5d5c51b.ta
* optee_test/out/ta/crypt/cb3e5ba0-adf1-11e0-998b0002a5d5c51b.ta
* optee_test/out/ta/rpc_test/d17f73a0-36ef-11e1-984a0002a5d5c51b.ta
* optee_test/out/ta/storage/b689f2a7-8adf-477a-9f9932e90c0ad0a2.ta
* optee_test/out/ta/create_fail_test/c3f6e2c0-3548-11e1-b86c0800200c9a66.ta

## Copy built files to the file system

**NOTE:** Make sure you complete building the OP-TEE driver, client and test suite first!

First download the latest Debian based build published [here](https://builds.96boards.org/snapshots/hikey/linaro/debian/latest). You can pick an eMMC rootfs:
* [hikey-jessie_[developer|alip]_YYYYMMDD-XXX.emmc.img.gz](https://builds.96boards.org/snapshots/hikey/linaro/debian/354/hikey-jessie_developer_20150929-354.emmc.img.gz)

For example, to download the latest Debian build 354:

```
wget https://builds.96boards.org/snapshots/hikey/linaro/debian/355/hikey-jessie_developer_20150929-354.emmc.img.gz
gunzip *.img.gz
```

To include the files compiled above in the downloaded jessie image you would:

a) install simg2img and make_ext4fs both from Linaro's modified package 'android-tools-fsutils' 

```
wget http://repo.linaro.org/ubuntu/linaro-overlay/pool/main/a/android-tools/\
> android-tools-fsutils_4.2.2+git20130218-3ubuntu41+linaro1_amd64.deb
sudo dpkg -i --force-all android-tools-fsutils_*.deb
```

b) then do the following 

```
simg2img hikey-jessie_developer_20150929-354.emmc.img raw.img
mkdir mnt
sudo mount raw.img mnt
cd mnt

sudo cp ${OPTEE_LINUXDRIVER_DIR}/core/optee.ko lib/modules/3.18.0-linaro-hikey/
sudo cp ${OPTEE_LINUXDRIVER_DIR}/armtz/optee_armtz.ko lib/modules/3.18.0-linaro-hikey/
sudo chown ubuntu:ubuntu lib/modules/3.18.0-linaro-hikey/optee*

sudo cp ${OPTEE_CLIENT_DIR}/out/export/bin/tee-supplicant bin/
sudo cp ${OPTEE_CLIENT_DIR}/out/export/lib/libteec.so.1.0 lib/aarch64-linux-gnu/
sudo ln -sf libteec.so.1.0 lib/aarch64-linux-gnu/libteec.so.1
sudo ln -sf libteec.so.1 lib/aarch64-linux-gnu/libteec.so

sudo cp ${OPTEE_TEST_DIR}/out/xtest/xtest bin/
sudo mkdir lib/optee_armtz
cp $(find ${OPTEE_TEST_DIR} -name *.ta) lib/optee_armtz/

sudo mkdir -p /data/tee

cd ..
sudo make_ext4fs -o -L rootfs -l 1500M -s jessie.updated.img mnt/
sudo umount mnt/
```

## Flash binaries to eMMC
In addition to the fip.bin and jessie.updated.img built and created above, you also need:

```shell
wget https://builds.96boards.org/snapshots/hikey/linaro/uefi/latest/l-loader.bin
wget https://builds.96boards.org/snapshots/hikey/linaro/uefi/latest/ptable-linux.img
wget https://builds.96boards.org/releases/hikey/linaro/binaries/latest/nvme.img
wget https://builds.96boards.org/snapshots/hikey/linaro/debian/latest/boot-fat.uefi.img.gz
gunzip *.img.gz
```

The flashing process requires to be in **recovery mode** if user wants to update l-loader.bin.

* turn off HiKey board
* connect debug UART on HiKey to PC (used to monitor debug status)
* make sure pin1-pin2 and pin3-pin4 on J15 are linked (recovery mode)
* connect HiKey Micro-USB to PC with USB cable
* turn on HiKey board
* on serial console, you should see some debug message (NULL packet)
* run [HiKey recovery tool](https://raw.githubusercontent.com/96boards/burn-boot/master/hisi-idt.py) to flash l-loader.bin (Note: if the serial port recorded in hisi-idt.py isn't available, adjust the command line below by manually setting the serial port with "-d /dev/ttyUSBx" where x is usually the last serial port reported by "dmesg" command)
```
$ sudo python hisi-idt.py --img1=l-loader.bin
```

**do not reboot yet**
* run fastboot commands to flash the images (**order must be respected**)
```
$ sudo fastboot flash ptable ptable-linux.img
$ sudo fastboot flash fastboot fip.bin
$ sudo fastboot flash nvme nvme.img
$ sudo fastboot flash boot boot-fat.uefi.img
$ sudo fastboot flash system jessie.updated.img
```
* turn off HiKey board
* remove the jumper of pin3-pin4 on J15
* turn on HiKey board

## Running and Testing

On the HiKey board serial console:

```
depmod
modprobe optee_armtz
tee-supplicant&
xtest
```
