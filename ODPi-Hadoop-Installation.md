This post concentrates on installing ODPi components built using Apache BigTop. These steps are only for configuring it on a single node and running them on a single node.

# Prerequisites:

* Java 7 installed (e.g. openjdk-7-jre: `sudo apt-get install openjdk-7-jre`)

# Repo:

ODPi deb and rpm packages can be found on Linaro repositories:

* Debian Jessie - http://repo.linaro.org/ubuntu/linaro-staging/
* CentOS 7 - http://repo.linaro.org/rpm/linaro-overlay/centos-7/


# Installation :

### On Debian:

add to repo source list

> $ echo "deb http://repo.linaro.org/ubuntu/linaro-staging jessie main" > /etc/apt/sources.list.d/linaro-overlay-repo.list

add the public key to authenticate package and add to trusted list
> $ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E13D88F7E3C1D56C

update the source list
> $ sudo apt-get update

Install all dependencies
> $ sudo apt-get build-dep build-essential

Install Hadoop packages 
> $ sudo apt-get install -ft jessie bigtop-tomcat hadoop* spark


### On CentOS:

> $ wget http://repo.linaro.org/rpm/linaro-overlay/centos-7/linaro-overlay.repo -O /etc/yum.repos.d/linaro-overlay.repo

> $ sudo yum update

> $ yum install [a-q]*

> $ yum install [s-z]*


### Verifying Installation 

Packages would get installed in /usr/lib 

type hadoop to check if hadoop is installed.
> $ hadoop 

### [Setup, Configuration and Running Hadoop](https://github.com/96boards/documentation/wiki/ODPi-BigTop-Hadoop-configuration-and-Running) 
#### Errors / Resolution