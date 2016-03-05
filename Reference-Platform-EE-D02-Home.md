[<<< Back to Reference Platform Home](https://github.com/96boards/documentation/wiki/Reference-Platform-Home#)

***

## D02

### Boot Firmware

The [UEFI/EDK2 guide for EE](https://github.com/96boards/documentation/wiki/UEFI-EDK2-Guide-for-EE) provides information about building and flashing the boot firmware for D02.

### Reference Platform Kernel

The Reference Platform kernel used by the enterprise release can be found on [github.com/96boards/linux](https://github.com/96boards/linux/tree/96b/releases/2016.03)

Since we use the same kernel config with all our builds and distributions, it is also available as part of the same kernel tree, and can be found at [arch/arm64/configs/distro.config](https://github.com/96boards/linux/blob/96b/releases/2016.03/arch/arm64/configs/distro.config).

At the time of the 16.03 release, the kernel is based on *4.4.0*.

For future releases we will also have kernel config fragments for key functionality that will make it easier for other projects and distributions to consume.

The Reference Platform kernel will act as an integration point (very similar to linux-next) for various upstream-targeted features and platform-enablement code on the latest kernel. Please read the [kernel policy](https://github.com/96boards/documentation/wiki/RP-Kernel-Policy) on how this kernel will be maintained. It is not meant to be a stable kernel - the [LSK](https://wiki.linaro.org/LSK) is already available for that.

### Quick Start

#### D02 - QuickStart

UEFI/EDK2 is supported by D02 (with build from source instructions available as part of the [UEFI EDK2 Guide](https://github.com/96boards/documentation/wiki/UEFI-EDK2-Guide-for-EE#building), and since ACPI support is new, please make sure you are using the latest firmware available at [https://builds.96boards.org/releases/reference-platform/components/uefi/16.03/release/d02/](https://builds.96boards.org/releases/reference-platform/components/uefi/16.03/release/d02/) before proceeding with kernel testing or installing your favorite distribution (and please make sure to report your firmware version when reporting issues and bugs).

##### Flashing the firmware

Follow the instructions available as part of the [UEFI EDK2 Guide](https://github.com/96boards/documentation/wiki/UEFI-EDK2-Guide-for-EE#d02) in order to flash your D02. The tested flashing process only requires access to a TFTP server, since the firmware supports fetching the firmware from the network.

### Network Installers

In order to install a distribution from network, PXE (DCHP/TFTP) booting is required. Since we require UEFI for the Enterprise Edition, the setup is usually easier since all you need is to load GRUB 2 (and its configuration). Check [this link](https://github.com/96boards/documentation/wiki/DHCP-TFTP-server-for-UEFI-distro-network-installers) for instructions on how to quickly setup your own PXE server (using *dnsmasq*).

Install instructions for the tested/supported distributions:
* [Debian 8.x 'Jessie'](https://github.com/96boards/documentation/wiki/Installing-Debian-Jessie)
* [CentOS 7](https://github.com/96boards/documentation/wiki/Installing-CentOS-7)

Test Reports: ([Debian Installer](https://builds.96boards.org/releases/reference-platform/components/debian-installer/16.03/EE-Debian-RPB-16.03-TestReport.pdf) / [CentOS Installer](https://builds.96boards.org/releases/reference-platform/components/centos-installer/16.03/EE-CentOS-RPB-16.03-TestReport.pdf))

#### Other distributions

Only Debian and CentOS are officially released and validated as part of the reference software platform project, but other distributions can be easily supported as well (just need kernel and installer changes).

Extra resources for other distributions:
* [Fedora 23](https://github.com/96boards/documentation/wiki/Installing-Fedora-23)

### Enterprise Software Components

#### OpenStack

Follow the [instructions](https://github.com/96boards/documentation/wiki/Openstack-Liberty) on how to install and run OpenStack Liberty on Debian Jessie.

#### Hadoop (ODPi BigTop)

##### Installation

Follow the [instructions](https://github.com/96boards/documentation/wiki/ODPi-Hadoop-Installation) to install ODPi BigTop Hadoop

##### Setup and Running Hadoop

Follow the [instructions](https://github.com/96boards/documentation/wiki/ODPi-BigTop-Hadoop-configuration-and-Running) to configure and install Hadoop