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


# Pre-Installation

## Verify/enable additional repositories

Verify that the `linaro-overly` and `jessie-backports` repositories are enabled.

If missing, add the following to /etc/apt/sources.list.d directory:

    $ sudo echo "deb http://repo.linaro.org/ubuntu/linaro-overlay jessie main" > /etc/apt/sources.list.d/linaro-overlay-repo.list`
    $ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E13D88F7E3C1D56C`

If missing, add the following to /etc/apt/sources.list.d directory:

    $ sudo echo "deb http://repo.linaro.org/ubuntu/linaro-overlay jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list`

If missing, add the following to /etc/apt/sources.list.d directory:

    $ sudo echo "deb http://repo.linaro.org/ubuntu/linaro-overlay testing main" > /etc/apt/sources.list.d/testing.list`

## Modify repository priorities

Create `/etc/apt/preferences.d/jessie-backports`:

    Package: *
    Pin: release a=jessie-backports
    Pin-Priority: 700

Create `/etc/apt/preferences.d/testing`:

    Package: *
    Pin: release a=testing
    Pin-Priority: 300

Then, make sure to run apt-get update:

    $ apt-get update

## Environment

Update /etc/hosts to add “controller” as an alias for localhost.

    127.0.0.1       localhost controller

## Disable IPV6

Add the following to /etc/sysctl.conf:

    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1
    net.ipv6.conf.eth0.disable_ipv6 = 1

Run sysctl to apply the changes:

    $ sudo sysctl -p

# Following the Openstack guide...

## Environment

### Openstack Packages

Do not enable the `cloud-archive:liberty` repository.

Install some dependencies:

    $ sudo apt-get install openstack-cloud-services

Answer the questions asked by debconf:

* New password for the MySQL "root" user: \<enter a password -- possibly "root">

Install the openstack client:

    $ apt-get install python-openstackclient python-pymysql

### NoSQL Database

The instructions in this section are not required, as Telemetry is not installed.

## Add the Identity service (Keystone)

### Install and configure

#### Prerequisites

Do not perform the database creation steps.  They will be done during meta package installation later.

#### Install and configure components

If you encounter dependency issues with package installation, you will need to manually install some dependency packages from testing first:

    $ sudo apt-get install python-cryptography/testing

Then, install the apache and the keystone meta package:

    $ sudo apt-get install openstack-cloud-identity

Answer the questions asked by debconf:

* Set up a database for Keystone: **Yes**
* Configure database for keystone with dbconfig-common: **Yes**
* Database type to be used by keystone: **mysql**
* Password of the database's administrative user: **\<use the password you used during database install>**
* MySQL application password for keystone: **\<enter a password>**
* Authentication server administration token: **\<enter a token value>**
* Register administration tenants? **Yes**
* Password of the administrative user: **\<enter a password>**
* Register Keystone endpoint? **Yes**
* Keystone endpoint IP address: **\<use default, or localhost, or controller>**

#### Finalize the installation

Nothing to do.

