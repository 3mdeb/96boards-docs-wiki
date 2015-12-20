This post concentrates on Running Hadoop after [installing](https://github.com/96boards/documentation/wiki/ODPi-Hadoop-Installation) ODPi components built using Apache BigTop. These steps are only for configuring it on a single node and running them on a single node.

Add hduser (dedicated user for running Hadoop) to hadoop usergroup:

    $ sudo adduser --ingroup hadoop hduser

Switch to hduser:

    $ su - hduser

Generate ssh key for hduser:

    $ ssh-keygen -t rsa -P ""

Enable ssh access to local machine:

    $ cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

Test ssh setup, as hduser:

    $ ssh localhost

Disabling IPv6:

    $ sudo nano /etc/sysctl.conf

Add the below lines and save:

    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1

Prefer IPv4 on Hadoop:

    $ sudo nano /etc/hadoop/conf/hadoop-env.sh

Uncomment line:

    # export HADOOP_OPTS=-Djava.net.preferIPV4stack=true

Save and restart the system.

Back to the system, configure the app environment:

    $ sudo mkdir -p /app/hadoop/tmp
    $ sudo chown hduser:hadoop /app/hadoop/tmp
    $ sudo chmod 750 /app/hadoop/tmp

Configure Environment Variables:

    $ su - hduser
    $ nano ~/.bashrc

Add the following and save:

    export HADOOP_HOME=/usr/local/hadoop
    export PATH=$PATH:$HADOOP_HOME/bin
    export HADOOP_PREFIX=$HADOOP_HOME
    export PATH=/usr/lib/hadoop/libexec:/etc/hadoop/conf:$HADOOP_HOME/bin/:$PATH
    export HADOOP_MAPRED_HOME=$HADOOP_HOME
    export HADOOP_COMMON_HOME=$HADOOP_HOME
    export HADOOP_HDFS_HOME=$HADOOP_HOME
    export YARN_HOME=$HADOOP_HOME
    export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
    export HADOOP_OPTS="-Djava.library.path=$HADOOP_PREFIX/lib/native"
    export HADOOP_YARN_HOME=$HADOOP_HOME
    export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
    export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
    export CLASSPATH=$CLASSPATH:.
    export CLASSPATH=$CLASSPATH:$HADOOP_HOME/libexec/share/hadoop/common/hadoop-common-2.2.0.jar
    export CLASSPATH=$CLASSPATH:$HADOOP_HOME/libexec/share/hadoop/hdfs/hadoop-hdfs-2.2.0.jar

Execute the terminal environment again (`bash`), or simply logout and change to `hduser` again.

Edit core-site.xml:

    $ cd /etc/hadoop/conf
    $ nano core-site.xml

And add the following:

    <property>
      <name>hadoop.tmp.dir</name>
      <value>/app/hadoop/tmp</value>
      <description>A base for other temporary directories.</description>
    </property>

    <property>
      <name>fs.default.name</name>
      <value>hdfs://localhost:54310</value>
      <description>The name of the default file system.  A URI whose
      scheme and authority determine the FileSystem implementation.  The
      uri's scheme determines the config property (fs.SCHEME.impl) naming
      the FileSystem implementation class.  The uri's authority is used to
      determine the host, port, etc. for a filesystem.</description>
    </property>

Edit mapred-site.xml:

    $ nano mapred-site.xml

And add the following lines: 

    <property>
      <name>mapred.job.tracker</name>
      <value>localhost:54311</value>
      <description>The host and port that the MapReduce job tracker runs
      at.  If "local", then jobs are run in-process as a single map
      and reduce task.
      </description>
    </property>

Edit hdfs-site.xml:

    $ nano hdfs-site.xml

And add the following lines:

    <property>
      <name>dfs.replication</name>
      <value>1</value>
      <description>Default block replication.
      The actual number of replications can be specified when the file is created.
      The default is used if replication is not specified in create time.
      </description>
    </property>

Format Namenode. This step is needed for the first time. Doing it every time will result in loss of content on HDFS.

    $ hadoop namenode –format

Start all hadoop services:

    $ start-all.sh

Check if hadoop is running. jps command should list namenode, datanode, yarn resource manager.

    $ jps