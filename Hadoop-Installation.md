This post concentrates on installing ODPi components built using Apache BigTop. These steps are only for configuring it on a single node and running them on a single node.

## Prerequisites:

√ Java 7 installed

## Repo:

ODPi deb and rpm packages can be found on Linaro repositories:

	• Debian Jessie - [http://repo.linaro.org/ubuntu/linaro-staging/](http://repo.linaro.org/ubuntu/linaro-staging/)
	• CentOS 7 - [http://repo.linaro.org/rpm/linaro-overlay/centos-7](http://repo.linaro.org/rpm/linaro-overlay/centos-7)


### To Install them:

h4. On CentOS:

$ wget http://repo.linaro.org/rpm/linaro-overlay/centos-7/linaro-overlay.repo -O /etc/yum.repos.d/linaro-overlay.repo

$ sudo yum update

h4. On Debian:

$ cd /etc/apt/sources.list.d

# add to repo list
$ sudo nano linaro-overlay-repo.list
— paste ‘deb http://repo.linaro.org/ubuntu/linaro-staging jessie main’
— save the file

# update the source list
$ sudo apt-get update

might give the following error 
W: GPG error: http://repo.linaro.org jessie InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY E13D88F7E3C1D56C

# add the public key to authenticate package and add to trusted list
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E13D88F7E3C1D56C

$ sudo apt-get update

# Install all dependencies
$ sudo apt-get build-dep build-essential

# Install hadoop packages 
$ sudo apt-get install -ft jessie bigtop-tomcat hadoop* spark

— — type hadoop to check if installed….