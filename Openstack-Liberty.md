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

Follow the Openstack guide with the exception of the following changes documented here.

### Install and configure

#### Prerequisites

Omit this section of the guide.  These operations will be done during meta package installation later.

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

#### Configure the Apache HTTP server

Omit this section of the guide.

#### Finalize the installation

Omit this section of the guide.

### Create the service entity and API endpoints

Omit this section of the guide.

### Create projects, users, and roles

Omit this section of the guide.



## Add the Image service (Glance)

Follow the Openstack guide with the exception of the following changes documented here.

### Install and configure

#### Prerequisites

Omit this section of the guide.  These operations will be done during package installation later.

#### Install and configure components

    $ sudo apt-get install glance python-glanceclient

Answer the questions asked by debconf:

**TODO: Verify debconf questions**

* Set up a database for Glance: **Yes**
* Configure database for glance-common with dbconfig-common? **Yes**
* Database type to be used by glance-common: **mysql**
* Password of the database's administrative user: **\<enter a password>**
* MySQL application password for glance-common: **\<enter a password>**
* IP address of your RabbitMQ host: **\<use default, or localhost, or controller>**
* Username for connection to the RabbitMQ server: **guest**
* Password for connection to the RabbitMQ server: **\<blank>**
* Auth server hostname: **\<use default, or localhost, or controller>**
* Auth server password: **\<enter a password>**
* Register Glance in the Keystone endpoint catalog? **Yes**
* Keystone authentication token: **\<enter the keystone token>**
* Pipeline flavor: **keystone**
* Authentication server hostname: **\<use default, or localhost, or controller>**
* Authentication server password: **\<enter a password>**

#### Finalize installation

Omit this section of the guide.



## Add the Compute service (Nova)

Follow the Openstack guide with the exception of the following changes documented here.

### Install and configure

#### Prerequisites

Omit this section of the guide.  These operations will be done during package installation later.

#### Install and configure components

    $ sudo apt-get install websockify/testing
    $ sudo apt-get install nova-api nova-cert nova-conductor \
      nova-consoleauth nova-novncproxy nova-scheduler \
      python-novaclient nova-compute

Answer the questions asked by debconf:

**TODO: Verify debconf questions**

* Set up a database for Nova: **Yes**
* Configure database for nova-common with dbconfig-common? **Yes**
* Database type to be used by nova-common: **mysql**
* Password of the database's administrative user: **\<enter a password>**
* MySQL application password for nova-common: **\<enter a password>**
* IP address of your RabbitMQ host: **\<use default, or localhost, or controller>**
* Username for connection to the RabbitMQ server: **guest**
* Password for connection to the RabbitMQ server: **\<blank>**
* Auth server hostname: **\<use default, or localhost, or controller>**
* Auth server password: **\<enter a password>**
* Neutron server URL: **http://\<use default, or localhost, or controller>:9696**
* Neutron administrator password: **\<enter a password>**
* Metadata proxy shared secret: **\<enter a shared secret string>**
* API to activate: **choose osapi_compute and metadata**
* Value for my_ip: **<default>**
* Register Nova in the Keystone endpoint catalog? **Yes**
* Keystone authentication token: **\<enter the keystone token>**

#### Finalize installation

Omit this section of the guide.



## Add the Networking service (Neutron)

Follow the Openstack guide with the exception of the following changes documented here.

### Install and configure

#### Prerequisites

Omit this section of the guide.  These operations will be done during package installation later.

#### Install and configure components

    $ sudo apt-get install neutron-server neutron-plugin-ml2 \
      neutron-plugin-linuxbridge-agent neutron-dhcp-agent \
      neutron-metadata-agent python-neutronclient

Answer the questions asked by debconf:

**TODO: Verify debconf questions**

* neutron-common
  * Set up a database for Neutron: **Yes**
  * Configure database for neutron-common with dbconfig-common? **Yes**
  * Database type to be used by neutron-common: **mysql**
  * Password of the database's administrative user: **\<enter a password>**
  * MySQL application password for neutron-common: **\<enter a password>**
  * IP address of your RabbitMQ host: **\<use default, or localhost, or controller>**
  * Username for connection to the RabbitMQ server: **guest**
  * Password for connection to the RabbitMQ server: **\<blank>**
  * Authentication server hostname: **\<use default, or localhost, or controller>**
  * Authentication server password: **\<enter a password>**
  * Neutron plugin: **ml2**
* neutron-metadata-agent
  * Auth server hostname: **\<use default, or localhost, or controller>**
  * Auth server password: **\<enter a password>**
  * Name of the region to be used by the metadata server: **\<default>**
  * Metadata proxy shared secret: **\<enter the shared secret string entered for Nova>**
  * Register Neutron in the Keystone endpoint catalog? **Yes**
  * Keystone authentication token: **\<enter the keystone token>**

#### Finalize installation

Omit this section of the guide.



## Launch an instance

### Create virtual networks

Follow section “Public provider network”

### Public provider network

Create the public network

Step (3) Match these values to your existing network.

Return to “Launch an instance”

### Launch an instance 

Follow section “Launch an instance on the public network”

### Launch an instance on the public network

#### Access the instance using the virtual console

Skip this section because VNC is disabled.

#### Access the instance remotely

Ensure that the instance has booted before attempting to access it over the network. This may take some time since the image is run using qemu without kvm.

To check progress use nova console-log to look at the output from the instance. The instance ID can be found using nova list.

    nova console-log --length=10 INSTANCE_ID
