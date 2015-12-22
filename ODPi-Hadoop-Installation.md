This post concentrates on installing ODPi components built using Apache BigTop. These steps configure and run the components on a single node.

# Prerequisites:

* Java 7 (e.g. openjdk-7-jre)

# Repo:

ODPi deb and rpm packages can be found on Linaro repositories:

* Debian Jessie - http://repo.linaro.org/ubuntu/linaro-overlay/
* CentOS 7 - http://repo.linaro.org/rpm/linaro-overlay/centos-7/


# Installation :

### On Debian:

Add to repo source list (**not required if you are using the installer from the Reference Platform**):

    sudo echo "deb http://repo.linaro.org/ubuntu/linaro-overlay jessie main" > /etc/apt/sources.list.d/linaro-overlay-repo.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E13D88F7E3C1D56C

Update the source list and install the dependencies:

    sudo apt-get update
    sudo apt-get install openssh-server rsync openjdk-7-jre
    sudo apt-get build-dep build-essential

Install Hadoop packages:
    
    sudo apt-get install -ft jessie bigtop-tomcat bigtop-utils hadoop* spark hue zookeeper hive hbase oozie pig mahout

### On CentOS:

    wget http://repo.linaro.org/rpm/linaro-overlay/centos-7/linaro-overlay.repo -O /etc/yum.repos.d/linaro-overlay.repo
    sudo yum update
    yum install [a-q]*
    yum install [s-z]*

### Verifying Installation 

Packages would get installed in /usr/lib 

Type hadoop to check if hadoop is installed:

    hadoop

And you should see the following:

    linaro@debian:~$ hadoop
    Usage: hadoop [--config confdir] COMMAND
           where COMMAND is one of:
      fs                   run a generic filesystem user client
      version              print the version
      jar <jar>            run a jar file
      checknative [-a|-h]  check native hadoop and compression libraries availability
      distcp <srcurl> <desturl> copy file or directories recursively
      archive -archiveName NAME -p <parent path> <src>* <dest> create a hadoop archive
      classpath            prints the class path needed to get the
      credential           interact with credential providers
                           Hadoop jar and the required libraries
      daemonlog            get/set the log level for each daemon
      trace                view and modify Hadoop tracing settings
     or
      CLASSNAME            run the class named CLASSNAME
     
    Most commands print help when invoked w/o parameters.

### [Setup, Configuration and Running Hadoop](https://github.com/96boards/documentation/wiki/ODPi-BigTop-Hadoop-configuration-and-Running) 
#### Errors / Resolution