# Introduction

In general, the instructions in the Liberty install guide should be followed: http://docs.openstack.org/liberty/install-guide-ubuntu/overview.html.  This guide will describe changes to the documented procedures that should be kept in mind while going through the guide.

Each section below will correspond to a section in the guide.  Guide sections that do not have a corresponding section below may be followed as-is.

# Release Notes

## Configuring images for aarch64

An image must be configured specially in glance to be able to boot correctly on aarch64.  
To attach the devices to the virtio bus (which does not allow hotplugging a volume, but will work if the image does not have SCSI support), the following properties must be set:

`
--property hw_machine_type=virt
--property os_command_line='root=/dev/vda rw rootwait console=ttyAMA0'
--property hw_cdrom_bus=virtio
`

To attach the devices to the SCSI bus (which does allow hotplugging a volume, but might not be supported by the guest image), the following properties must be set:

` 
--property hw_scsi_model='virtio-scsi'
--property hw_disk_bus='scsi'
--property os_command_line='root=/dev/sda rw rootwait console=ttyAMA0'
`

You can set these properties when you are uploading the image into glance, or modify the image if you have already uploaded it.


# Installation

## Verify/enable additional repositories

Verify that the `linaro-overly` and `jessie-backports` repositories are enabled.

If missing, add the following to /etc/apt/sources.list.d directory:

    $ sudo echo "deb http://repo.linaro.org/ubuntu/linaro-overlay jessie main" > /etc/apt/sources.list.d/linaro-overlay-repo.list`
    $ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E13D88F7E3C1D56C`

If missing, add the following to /etc/apt/sources.list.d directory:

    $ sudo echo "deb http://repo.linaro.org/ubuntu/linaro-overlay jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list`

Create `/etc/apt/preferences.d/jessie-backports`:

    Package: *
    Pin: release a=jessie-backports
    Pin-Priority: 700

Then, make sure to run apt-get update:

    $ apt-get update

## Environment

Update /etc/hosts to add “controller” as an alias for localhost.

    127.0.0.1       localhost controller

### Disable IPV6

Add the following to /etc/sysctl.conf:

    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1
    net.ipv6.conf.eth0.disable_ipv6 = 1

Run sysctl to apply the changes:

    $ sudo sysctl -p

### Openstack Packages

Do not enable the `cloud-archive:liberty` repository.

### NoSQL Database

The instructions in this section are not required, as Telemetry is not installed.

## Add the Identity service

Follow the Openstack guide.

