# Installing Openstack Liberty

## Introduction

In general, the instructions in the Liberty install guide should be followed: http://docs.openstack.org/liberty/install-guide-ubuntu/overview.html.  This guide will describe changes to the documented procedures that should be kept in mind while going through the guide.

Each page below will correspond to a section in the guide.  Guide sections that do not have a corresponding page below may be followed as-is.

## Verify/enable additional repositories

Verify that the linaro-overly and jessie backports repositories are enabled.

If missing, add the following to /etc/apt/sources.list.d directory:

`$ sudo echo "deb http://repo.linaro.org/ubuntu/linaro-overlay jessie main" > /etc/apt/sources.list.d/linaro-overlay-repo.list`
`$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E13D88F7E3C1D56C`

If missing, add the following to /etc/apt/sources.list.d directory:

`$ sudo echo "deb http://repo.linaro.org/ubuntu/linaro-overlay jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list`

Then, make sure to run apt-get update:

`apt-get update`


