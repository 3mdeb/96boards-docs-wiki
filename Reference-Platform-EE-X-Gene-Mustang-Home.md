[<<< Back to Reference Platform Home](https://github.com/96boards/documentation/wiki/Reference-Platform-Home#)

***

## X-Gene Mustang

### Boot Firmware

TBD

### Reference Platform Kernel

The Reference Platform kernel used by the enterprise release can be found on [github.com/96boards/linux](https://github.com/96boards/linux/tree/96b/releases/2016.03)

Since we use the same kernel config with all our builds and distributions, it is also available as part of the same kernel tree, and can be found at [arch/arm64/configs/distro.config](https://github.com/96boards/linux/blob/96b/releases/2016.03/arch/arm64/configs/distro.config).

At the time of the 16.03 release, the kernel is based on *4.4.0*.

For future releases we will also have kernel config fragments for key functionality that will make it easier for other projects and distributions to consume.

The Reference Platform kernel will act as an integration point (very similar to linux-next) for various upstream-targeted features and platform-enablement code on the latest kernel. Please read the [kernel policy](https://github.com/96boards/documentation/wiki/RP-Kernel-Policy) on how this kernel will be maintained. It is not meant to be a stable kernel - the [LSK](https://wiki.linaro.org/LSK) is already available for that.

### Network Installers

In order to install a distribution from network, PXE (DCHP/TFTP) booting is required. Since we require UEFI for the Enterprise Edition, the setup is usually easier since all you need is to load GRUB 2 (and its configuration). Check [this link](https://github.com/96boards/documentation/wiki/DHCP-TFTP-server-for-UEFI-distro-network-installers) for instructions on how to quickly setup your own PXE server (using *dnsmasq*).

Install instructions for the tested/supported distributions:
* [Debian 8.x 'Jessie'](https://github.com/96boards/documentation/wiki/Installing-Debian-Jessie)
* [CentOS 7](https://github.com/96boards/documentation/wiki/Installing-CentOS-7)

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
