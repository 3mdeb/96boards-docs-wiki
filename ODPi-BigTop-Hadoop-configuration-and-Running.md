This post concentrates on Running Hadoop after [installing](https://github.com/96boards/documentation/wiki/ODPi-Hadoop-Installation) ODPi components built using Apache BigTop. These steps are only for configuring it on a single node and running them on a single node.

# Add Hadoop User
 We need to create a dedicated user (hduser) for running Hadoop. This user needs to be added to hadoop usergroup:

    sudo useradd -G hadoop hduser

give a password for hduser

    sudo passwd hduser

Add hduser to sudoers list  
On Debian:

    sudo adduser hduser sudo

On Centos:

    sudo usermod -G wheel hduser

Switch to hduser:

    sudo su - hduser

# Generate ssh key for hduser

    ssh-keygen -t rsa -P ""

Press \<enter\> to leave to default file name.

Enable ssh access to local machine:

    cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

Test ssh setup, as hduser:

    ssh localhost

# Disabling IPv6

    sudo nano /etc/sysctl.conf

Add the below lines to the end and save:

    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1

Prefer IPv4 on Hadoop:

    sudo nano /etc/hadoop/conf/hadoop-env.sh

Uncomment line:

    # export HADOOP_OPTS=-Djava.net.preferIPV4stack=true

Save and restart the system.

# Configuring the app environment
Back to the system, we need to configure the app environment by following steps:

    sudo mkdir -p /app/hadoop/tmp
    sudo chown hduser:hadoop /app/hadoop/tmp
    sudo chmod 750 /app/hadoop/tmp
    sudo chown hduser:hadoop /usr/lib/hadoop
    sudo chmod 750 /usr/lib/hadoop

# Setting up Environment Variables
Follow the below steps to setup Environment Variables in bash file :

    sudo su - hduser
    nano .bashrc

Add the following to the end and save:

    export HADOOP_HOME=/usr/lib/hadoop
    export HADOOP_PREFIX=$HADOOP_HOME
    export HADOOP_OPTS="-Djava.library.path=$HADOOP_PREFIX/lib/native"
    export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec
    export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
    export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
    export HADOOP_COMMON_HOME=$HADOOP_HOME
    export HADOOP_MAPRED_HOME=/usr/lib/hadoop-mapreduce
    export HADOOP_HDFS_HOME=/usr/lib/hadoop-hdfs
    export YARN_HOME=/usr/lib/hadoop-yarn
    export HADOOP_YARN_HOME=/usr/lib/hadoop-yarn/
    export CLASSPATH=$CLASSPATH:.
    export CLASSPATH=$CLASSPATH:$HADOOP_HOME/hadoop-common-2.6.0.jar
    export CLASSPATH=$CLASSPATH:$HADOOP_HOME/client/hadoop-hdfs-2.6.0.jar
    export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
    export PATH=/usr/lib/hadoop/libexec:/etc/hadoop/conf:$HADOOP_HOME/bin/:$PATH

Execute the terminal environment again (`bash`), or simply logout and change to `hduser` again.

Edit core-site.xml:

    cd /etc/hadoop/conf
    sudo nano core-site.xml

And add/modify the following settings:
Look for property with <name> fs.defaultFS</name> and modify as below:

    <property>
      <name>fs.default.name</name>
      <value>hdfs://localhost:54310</value>
      <description>The name of the default file system.  A URI whose
      scheme and authority determine the FileSystem implementation.  The
      uri's scheme determines the config property (fs.SCHEME.impl) naming
      the FileSystem implementation class.  The uri's authority is used to
      determine the host, port, etc. for a filesystem.</description>
    </property>

Add this to the bottom before \</configuration> tag:

    <property>
      <name>hadoop.tmp.dir</name>
      <value>/app/hadoop/tmp</value>
      <description>A base for other temporary directories.</description>
    </property>


Edit mapred-site.xml:

    sudo nano mapred-site.xml

Modify existing properties as follows: 
Look for property tag with <name> as mapred.job.tracker and modify as below:

    <property>
      <name>mapred.job.tracker</name>
      <value>localhost:54311</value>
      <description>The host and port that the MapReduce job tracker runs
      at.  If "local", then jobs are run in-process as a single map
      and reduce task.
      </description>
    </property>

Edit hdfs-site.xml:

    sudo nano hdfs-site.xml

Modify existing property as below :

    <property>
      <name>dfs.replication</name>
      <value>1</value>
      <description>Default block replication.
      The actual number of replications can be specified when the file is created.
      The default is used if replication is not specified in create time.
      </description>
    </property>

# Format Namenode
This step is needed for the first time. Doing it every time will result in loss of content on HDFS.

    sudo /etc/init.d/hadoop-hdfs-namenode init

# Start the YARN daemons

    for i in hadoop-hdfs-namenode hadoop-hdfs-datanode ; do sudo service $i start ; done
    sudo /etc/init.d/hadoop-yarn-resourcemanager start
    sudo /etc/init.d/hadoop-yarn-nodemanager start

# Validating Hadoop
Check if hadoop is running. jps command should list namenode, datanode, yarn resource manager. or use ps aux 

    sudo jps
or

    ps aux | grep java

Alternatively, check if yarn managers are running:
    
    sudo /etc/init.d/hadoop-yarn-resourcemanager status
    sudo /etc/init.d/hadoop-yarn-nodemanager status

You would see like below:

    ● hadoop-yarn-nodemanager.service - LSB: Hadoop nodemanager
        Loaded: loaded (/etc/init.d/hadoop-yarn-nodemanager)
        Active: active (running) since Tue 2015-12-22 18:25:03 UTC; 1h 24min ago
        CGroup: /system.slice/hadoop-yarn-nodemanager.service
                └─10366 /usr/lib/jvm/java-1.7.0-openjdk-arm64/bin/java -Dproc_node...

    Dec 22 18:24:57 debian su[10348]: Successful su for yarn by root
    Dec 22 18:24:57 debian su[10348]: + ??? root:yarn
    Dec 22 18:24:57 debian su[10348]: pam_unix(su:session): session opened for ...0)
    Dec 22 18:24:57 debian hadoop-yarn-nodemanager[10305]: starting nodemanager, ...
    Dec 22 18:24:58 debian su[10348]: pam_unix(su:session): session closed for ...rn
    Dec 22 18:25:03 debian hadoop-yarn-nodemanager[10305]: Started Hadoop nodeman...



## Run teragen, terasort and teravalidate ##
    hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar teragen 1000000 terainput

    hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar terasort terainput teraoutput

    hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar teravalidate -D mapred.reduce.tasks=8 teraoutput teravalidate


## Stop the Hadoop services ##

    sudo /etc/init.d/hadoop-yarn-nodemanager stop
    
    sudo /etc/init.d/hadoop-yarn-resourcemanager stop

    for i in hadoop-hdfs-namenode hadoop-hdfs-datanode ; do sudo service $i stop; done
    

## Potential Errors / Issues and Resolutions ##
* If Teragen, TeraSort and TeraValidate error out with 'permission denied' exception. The following steps can be done:

        sudo groupadd supergroup

        sudo usermod -g supergroup hduser


*  If for some weird reason, if you notice the config files (core-site.xml, hdfs-site.xml, etc) are empty.

    You may have delete all the packages and re-run the steps of installation from scratch.

*  Error while formatting namenode 
With the following command:

    sudo /etc/init.d/hadoop-hdfs-namenode init

If you see the following error:
    WARN net.DNS: Unable to determine local hostname -falling back to "localhost"
    java.net.UnknownHostException: centos: centos
	at java.net.InetAddress.getLocalHost(InetAddress.java:1496)
	at org.apache.hadoop.net.DNS.resolveLocalHostname(DNS.java:264)
	at org.apache.hadoop.net.DNS.<clinit>(DNS.java:57)

Something is wrong in the network setup. Please check /etc/hosts file.

   

## Potential Errors / Issues and Resolutions ##
* If Teragen, TeraSort and TeraValidate error out with 'permission denied' exception. The following steps can be done:

    sudo groupadd supergroup
    sudo usermod -g supergroup hduser

*  If for some weird reason, if you notice the config files (core-site.xml, hdfs-site.xml, etc) are empty.

    You may have to delete all the packages and re-run the steps of installation from scratch.

*  Error while formatting namenode 
With the following command:

    sudo /etc/init.d/hadoop-hdfs-namenode init

If you see the following error:
    WARN net.DNS: Unable to determine local hostname -falling back to "localhost"
    java.net.UnknownHostException: centos: centos
	at java.net.InetAddress.getLocalHost(InetAddress.java:1496)
	at org.apache.hadoop.net.DNS.resolveLocalHostname(DNS.java:264)
	at org.apache.hadoop.net.DNS.<clinit>(DNS.java:57)

Something is wrong in the network setup. Please check /etc/hosts file.

