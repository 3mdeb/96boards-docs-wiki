[<<< Back to Reference Platform Home](https://github.com/96boards/documentation/wiki/Reference-Platform-Home)

***

### QuickStart

- **Juno R0/R1**
- [**HiSilicon D02**](https://github.com/96boards/documentation/wiki/ReferenceSoftwareEE#hisilicon-d02)
- [**AMD Overdrive**](https://github.com/96boards/documentation/wiki/ReferenceSoftwareEE#amd-overdrive)

***

### Boot Firmware (UEFI/EDK2) ( NEEDS REVISION )

EDK2 is a modern, feature-rich, cross-platform firmware development environment for the UEFI and PI specifications.

The reference UEFI/EDK2 tree used by the EE-RPB comes directly from [upstream](https://github.com/tianocore/edk2), based on a specific commit that gets validated and published as part of the Linaro EDK2 effort (which is available at [https://git.linaro.org/uefi/linaro-edk2.git](https://git.linaro.org/uefi/linaro-edk2.git).

Since there is no hardware specific support as part of EDK2 upstream, an external module called [OpenPlatformPkg](https://git.linaro.org/uefi/OpenPlatformPkg.git) is also required as part of the build process.

EDK2 is currently used by 96boards HuskyBoard, AMD Overdrive, ARM Juno r0/r1 and HiSilicon D02.

This guide provides enough information on how to build UEFI/EDK2 from scratch, but meant to be a quick guide. For further information please also check the official Linaro UEFI documentation, available at [https://wiki.linaro.org/ARM/UEFI](https://wiki.linaro.org/ARM/UEFI) and  [https://wiki.linaro.org/LEG/Engineering/Kernel/UEFI/build](https://wiki.linaro.org/LEG/Engineering/Kernel/UEFI/build)

- Build ([Pre-Requisites](https://github.com/96boards/documentation/wiki/UEFI-EDK2-Guide-for-EE#pre-requisites) / [Getting Source](https://github.com/96boards/documentation/wiki/UEFI-EDK2-Guide-for-EE#getting-the-source-code))
- Juno R0/R1 ([Build](https://github.com/96boards/documentation/wiki/UEFI-EDK2-Guide-for-EE#building-uefiedk2-for-juno-r0r1) / [Flash](https://github.com/96boards/documentation/wiki/UEFI-EDK2-Guide-for-EE#juno-r0r1))
- HiSilicon D02 ([Build](https://github.com/96boards/documentation/wiki/UEFI-EDK2-Guide-for-EE#building-uefiedk2-for-d02) / [Flash](https://github.com/96boards/documentation/wiki/UEFI-EDK2-Guide-for-EE#d02))
- Overdrive ([Build](https://github.com/96boards/documentation/wiki/UEFI-EDK2-Guide-for-EE#building-uefiedk2-for-overdrive) / [Flash](https://github.com/96boards/documentation/wiki/UEFI-EDK2-Guide-for-EE#amd-overdrive))

***

### Reference Platform Kernel ( NEEDS REVISION )

The Reference Platform kernel used by the enterprise release (and soon to be shared with CE) can be found on [git.linaro.org](https://git.linaro.org/people/amit.kucheria/kernel.git/shortlog/refs/heads/96b/releases/2015.12)

Since we want the same kernel config to be used for all our builds and distributions, it is also available as part of the same kernel tree, and can be found at [arch/arm64/configs/distro.config](https://git.linaro.org/people/amit.kucheria/kernel.git/blob/refs/heads/96b/releases/2015.12:/arch/arm64/configs/distro.config)

At the time of the 15.12 release, the kernel is based on `4.4-rc4`.

For future releases we will also have kernel config fragments for key functionality that will make it easier for other projects and distributions to consume.

The Reference Platform kernel will act as an integration point (very similar to linux-next) for various upstream-targeted features and platform-enablement code on the latest kernel. Please read the [kernel policy](https://github.com/96boards/documentation/wiki/RP-Kernel-Policy) on how this kernel will be maintained. It is not meant to be a stable kernel - the [LSK](https://wiki.linaro.org/LSK) is already available for that.

***

### Network Installers

###### Tested and Supported Distributions

<p align="left">
  <b>Debian 'Jessie'</b><br>
  <a href="#">[TFTP server setup](https://github.com/96boards/documentation/wiki/Installing-Debian-Jessie#setting-up-the-tftp-server)</a> |
  <a href="#">[Download](https://github.com/96boards/documentation/wiki/Installing-Debian-Jessie#downloading-debian-installer)</a> |
  <a href="#">[Booting the installer](https://github.com/96boards/documentation/wiki/Installing-Debian-Jessie#booting-the-installer)</a> |
  <a href="#">[Preseeding](https://github.com/96boards/documentation/wiki/Installing-Debian-Jessie#automating-the-installation-using-preseeding)</a> |
  <a href="#">[Build from Source](https://github.com/96boards/documentation/wiki/Installing-Debian-Jessie#building-debian-installer-from-source)</a>
  <br>

<p align="left">
  <b>CentOS</b><br>
  <a href="#">[TFTP server setup](https://github.com/96boards/documentation/wiki/Installing-CentOS-7#setting-up-the-tftp-server)</a> |
  <a href="#">[Download](https://github.com/96boards/documentation/wiki/Installing-CentOS-7#downloading-the-centos-upstream-kernel-42-compatible-with-overdrive-and-mustang-and-initrd)</a> |
  <a href="#">[Booting the installer](https://github.com/96boards/documentation/wiki/Installing-CentOS-7#booting-the-installer)</a> |
  <a href="#">[Kickstart](https://github.com/96boards/documentation/wiki/Installing-CentOS-7#automating-the-installation-with-kickstart)</a>
  <br>
       

###### Other Distributions

<p align="left">
  <b>Fedora 23</b><br>
  <a href="#">[TFTP server setup](https://github.com/96boards/documentation/wiki/Installing-Fedora-23#setting-up-the-tftp-server)</a> |
  <a href="#">[Booting the installer](https://github.com/96boards/documentation/wiki/Installing-Fedora-23#booting-the-installer)</a> |
  <a href="#">[Kickstart](https://github.com/96boards/documentation/wiki/Installing-Fedora-23#automating-the-installation-with-kickstart)</a>
  <br>

***


### Enterprise Software Components

<p align="left">
  <b>OpenStack Liberty on Debian Jessie</b><br>
  <a href="#">[Read More](https://github.com/96boards/documentation/wiki/Openstack-Liberty#introduction)</a> |
  <a href="#">[Release Notes](https://github.com/96boards/documentation/wiki/Openstack-Liberty#release-notes)</a> |
  <a href="#">[Pre-Installation](https://github.com/96boards/documentation/wiki/Openstack-Liberty#pre-installation)</a> |
  <a href="#">[Guide](https://github.com/96boards/documentation/wiki/Openstack-Liberty#following-the-openstack-guide)</a> |
  <a href="#">[Add-ons](https://github.com/96boards/documentation/wiki/Openstack-Liberty#add-the-image-service-glance)</a> |
  <a href="#">[Launch Instance](https://github.com/96boards/documentation/wiki/Openstack-Liberty#launch-an-instance)</a>
  <br>


<p align="left">
  <b>Hadoop (ODPi BigTop)</b><br>
  <a href="#">[Prerequisites](https://github.com/96boards/documentation/wiki/ODPi-Hadoop-Installation#prerequisites)</a> |
  <a href="#">[Installation](https://github.com/96boards/documentation/wiki/ODPi-Hadoop-Installation#installation-)</a> |
  <a href="#">[Setup and Run](https://github.com/96boards/documentation/wiki/ODPi-BigTop-Hadoop-configuration-and-Running)</a>
  <br>