# Hadoop Setup

This will create a Hadoop cluster using containernet. In other words, you will have a Hadoop cluster containing some Docker containers. The cluster can be created on a single machine or a single cloud instance. If you intend to create a Hadoop cluster containing several nodes of real machines, you can setup your cluster using Apache Ambari instead.

These steps are tested for Google Cloud Platform and Vultr. However, I think as long as you follow the steps, you can use it for other cloud services and servers.

## Use root user

Don't worry, we will not install anything in your root account. We use root because all settings in the cloud are designed to run using root user.

```
$ sudo su
Password: 
# 
```

## Generate ssh-key
You can save it as default `id_rsa` file in `/var/root/.ssh` folder or put it somewhere else. In the example below, I put it in `/var/root/.ssh` and name it as `myhadoop`.

```
# ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/var/root/.ssh/id_rsa): /var/root/.ssh/myhadoop
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /var/root/.ssh/myhadoop.
Your public key has been saved in /var/root/.ssh/myhadoop.pub.
The key fingerprint is:
SHA256:eDk0Xy1G9NIkVrNINWQuC1kXmBmXxhzqikj3wtGJ1CY root@Arwans-Air
The key's randomart image is:
+---[RSA 2048]----+
|           .O@&+ |
|         . *+&=+ |
|        E = O.*  |
|       + O * =   |
|      o S + o    |
|     . = = .     |
|      . + o      |
|         .       |
|                 |
+----[SHA256]-----+

```
## Work with Google Cloud Platform (GCP)

Google is so generous. They will give you $300 credit that you can use it in GCP within 1 year. After you activate your GCP account and get the credit, you can go to `https://console.cloud.google.com/` and do the following steps

### Create Instansce

1. Go to the hamburger menu at the top left, 
2. Click on `compute engine`. 
3. Click `create instance` and choose whatever you like there (e.g. Debian or Ubuntu or else, how many CPU and RAM used, etc). Ensure that `Allow HTTPS traffic` is chosen.
4. Click on `Management, disk, networking and SSH Keys` and click again on `SSH Keys`
5. Go back to your terminal to copy your SSH key. If you work on Linux, you can use this command to display your SSH key so you can copy and paste in the GCP `cat /var/root/.ssh/myhadoop.pub`. If you are on Mac, you can use this command and the SSH Key is copied into your clipboard `cat /var/root/.ssh/myhadoop.pub | pbcopy`
6. Click `create`
7. Stop the instance and click `edit`
8. Click on `Enable connecting to serial ports` and click `save`
9. Rerun the instance. Now you can see that it has two IP addresses. One internal IP and one external IP. When you see that, congratulations! Your instance is created successfully! :D

### SSH from terminal

Say that the external IP is `35.238.22.12`. You can ensure that it is reachable by using `ping` command

```
ping -c 3 35.238.22.12
```

If it is pingable, you can connect to the instance from your terminal

```
ssh -Y root@35.238.22.12
```

You may find the output like this

```
# ssh -Y root@35.238.22.12
The authenticity of host '35.238.22.12 (35.238.22.12)' can't be established.
ECDSA key fingerprint is SHA256:sNNiKfB0JQnavVJia/V5zZJjKR6MsxYEWJoIBJ3TIFk.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '35.238.22.12' (ECDSA) to the list of known hosts.
/opt/X11/bin/xauth:  file /var/root/.Xauthority does not exist
                                                              Welcome to Ubuntu 16.04.4 LTS (GNU/Linux 4.13.0-1017-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

2 packages can be updated.
2 updates are security updates.


Last login: Thu May 24 09:34:03 2018 from 183.171.232.237
root@hadoop:~#
```

## Prepare The Cluster

### Clone hadoopSetup

```
# git clone https://github.com/arwankhoiruddin/hadoopSetup.git
```

The output may be like this

```
Cloning into 'hadoopSetup'...
remote: Counting objects: 183, done.
remote: Compressing objects: 100% (28/28), done.
remote: Total 183 (delta 12), reused 2 (delta 0), pack-reused 154
Receiving objects: 100% (183/183), 42.95 KiB | 0 bytes/s, done.
Resolving deltas: 100% (93/93), done.
Checking connectivity... done.
root@hadoop:~#
```

### Plan the Scheduler
By default, Hadoop is shipped with three schedulers i.e. FIFO, Capacity and Fair scheduler. If you plan to use FIFO, you can skip this step. However, if you want to use another scheduler, you can do the following step

If you want to use Fair Scheduler
```
# cd hadoopSetup
# git pull origin fairsched
```

If you want to use Capacity Scheduler
```
# cd hadoopSetup
# git pull origin capacitysched
```

### Install everything

In this steps, you will run a shell script that will do the followings:

1. Install `oracle-java8` and other dependencies
2. Download and install `containernet`
3. Download an example of the emulated network in `containernet`
4. Pull one of the Docker instance i.e. `arwankhoiruddin/heterodoop`
5. Download Hadoop

What you need to do is just run a single shell script i.e. `prepare.sh`. Here's how you do that

If you are not in hadoopSetup directory yet, go to the directory, otherwise, just do the next command
```
# cd hadoopSetup
# ./prepare.sh
```

The output will be like this

```
Oracle Java (JDK) Installer (automatically downloads and installs Oracle JDK8). There are no actual Java files in this PPA.

Important -> Why Oracle Java 7 And 6 Installers No Longer Work: http://www.webupd8.org/2017/06/why-oracle-java-7-and-6-installers-no.html

Update: Oracle Java 9 has reached end of life: http://www.oracle.com/technetwork/java/javase/downloads/jdk9-downloads-3848520.html

The PPA supports Ubuntu 18.04, 17.10, 16.04, 14.04 and 12.04.

More info (and Ubuntu installation instructions):
- for Oracle Java 8: http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html

Debian installation instructions:
- Oracle Java 8: http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html

For Oracle Java 10, see a different PPA: https://www.linuxuprising.com/2018/04/install-oracle-java-10-in-ubuntu-or.html
 More info: https://launchpad.net/~webupd8team/+archive/ubuntu/java
Press [ENTER] to continue or ctrl-c to cancel adding it
```

Just press `[enter]` then it will continue automagically. In the middle, you will need to confirm again. Just click `OK` or `yes`.

When you reach these lines, you can start to put your smile in your face! You have what you need to setup a cluster.

```
hadoop-2.9.0/share/hadoop/common/jdiff/Apache_Hadoop_Common_2.7.2.xml
hadoop-2.9.0/share/hadoop/common/sources/
hadoop-2.9.0/share/hadoop/common/sources/hadoop-common-2.9.0-test-sources.jar
hadoop-2.9.0/share/hadoop/common/sources/hadoop-common-2.9.0-sources.jar
root@hadoop:~/hadoopSetup# 
```

### Create the cluster

To create the cluster, you need to run `mynet.py` in `research` folder. To do so, type this in your terminal

```
cd ../research
./mynet.py
```

The output will be

```
*** Adding controller
*** Adding docker containers
{'publish_all_ports': True, 'dns': [], 'ip': '10.0.0.251', 'network_mode': None, 'cpuset_cpus': None, 'cpu_quota': -1, 'cpu_period': None, 'memswap_limit': None, 'cpu': 1, 'environment': {}, 'volumes': ['/root/hadoopSetup:/hadoopSetup', '/root/research/hd29:/usr/local/hadoop'], 'mem_limit': None, 'port_bindings': {}, 'ports': [], 'cpu_shares': None}
d1: kwargs {'ip': '10.0.0.251', 'cpu': 1, 'volumes': ['/root/hadoopSetup:/hadoopSetup', '/root/research/hd29:/usr/local/hadoop']}
d1: update resources {'cpu_quota': -1}
{'publish_all_ports': True, 'dns': [], 'ip': '10.0.0.252', 'network_mode': None, 'cpuset_cpus': None, 'cpu_quota': -1, 'cpu_period': None, 'memswap_limit': None, 'cpu': 1, 'environment': {}, 'volumes': ['/root/hadoopSetup:/hadoopSetup', '/root/research/hd29:/usr/local/hadoop'], 'mem_limit': None, 'port_bindings': {}, 'ports': [], 'cpu_shares': None}
d2: kwargs {'ip': '10.0.0.252', 'cpu': 1, 'volumes': ['/root/hadoopSetup:/hadoopSetup', '/root/research/hd29:/usr/local/hadoop']}
d2: update resources {'cpu_quota': -1}
{'publish_all_ports': True, 'dns': [], 'ip': '10.0.0.253', 'network_mode': None, 'cpuset_cpus': None, 'cpu_quota': -1, 'cpu_period': None, 'memswap_limit': None, 'cpu': 1, 'environment': {}, 'volumes': ['/root/hadoopSetup:/hadoopSetup', '/root/research/hd29:/usr/local/hadoop'], 'mem_limit': None, 'port_bindings': {}, 'ports': [], 'cpu_shares': None}
d3: kwargs {'ip': '10.0.0.253', 'cpu': 1, 'volumes': ['/root/hadoopSetup:/hadoopSetup', '/root/research/hd29:/usr/local/hadoop']}
d3: update resources {'cpu_quota': -1}
{'publish_all_ports': True, 'dns': [], 'ip': '10.0.0.254', 'network_mode': None, 'cpuset_cpus': None, 'cpu_quota': -1, 'cpu_period': None, 'memswap_limit': None, 'cpu': 1, 'environment': {}, 'volumes': ['/root/hadoopSetup:/hadoopSetup', '/root/research/hd29:/usr/local/hadoop'], 'mem_limit': None, 'port_bindings': {}, 'ports': [], 'cpu_shares': None}
d4: kwargs {'ip': '10.0.0.254', 'cpu': 1, 'volumes': ['/root/hadoopSetup:/hadoopSetup', '/root/research/hd29:/usr/local/hadoop']}
d4: update resources {'cpu_quota': -1}
*** Adding switches
*** Creating links
*** Starting network
*** Configuring hosts
d1 d2 d3 d4 
*** Starting controller
c0 
*** Starting 3 switches
s1 s2 s3 ...
*** Testing connectivity
*** Ping: testing ping reachability
d1 -> d2 d3 d4 
d2 -> d1 d3 d4 
d3 -> d1 d2 d4 
d4 -> d1 d2 d3 
*** Results: 0% dropped (12/12 received)
*** Running CLI
*** Starting CLI:
containernet> 
```

Now you have a cluster that has 4 nodes i.e. `d1, d2, d3`, and `d4`. 

### Set the slaves

```
containernet> xterm d2 d3 d4
```

This command will open 3 (three) xterminal for you. If you are working on GDP or Vultr, it may take some time before the xterminal comes out.

Basically each xterminal is a terminal interface for node `d1`, `d2` and `d3`. For each xterminal, do the followings (in this step, in one of the command, it will ask you for a password. Don't worry, the password for the node is `arwan`).

```
# su hduser
$ cd hadoopSetup
$ sudo ./deploy.sh
password:
```

`deploy.sh` will copy all the hadoop configuration as well as the networking and local configuration (e.g. `/etc/hosts` and `bashrc`). However, you need to reload the `bashrc` using the following command.

``` 
$ source ~/.bashrc
```

Last step, on each xterminal, you need to start the SSH Server

```
$ sudo service ssh restart
```

Do the above steps for `d2`, `d3` and `d4`, then you can close all the xterminal.

### Set the master

Now go back to your terminal again. Open xterminal for the master node (`d1`).

```
containernet> xterm d1
```

After the xterminal is opened, do the exact same steps with the slaves i.e.

```
# su hduser
$ cd hadoopSetup
$ sudo ./deploy.sh
$ source ~/.bashrc
$ sudo service ssh restart
```

Because it is master, you need to have some extra things to do i.e. create `masters` file in Hadoop configuration, generate ssh-key in master and copy them into the slaves

```
$ nano $HADOOP_HOME/etc/hadoop/masters
```
The file is empty, so you just need to add a single line there

```
d1
```
Save the file using `ctrl+x` then `y` then `[enter]`

Now, the last step is to generate the ssh-key and copy them in all slaves. Simply run the following shell script

```
$ ./copyssh.sh
```

Follow all the steps, don't forget, if it asks for password, the password is `arwan`

Now check if you can ssh to other nodes 

```
$ ssh d1
$ exit
$ ssh d2
$ exit
$ ssh d3
$ exit
$ ssh d4
$ exit
```

### Format the namenode

Yay! Now you are ready to run Hadoop! First step is to format the namenode. In xterminal in `d1`, run the following command

```
$ hadoop namenode -format
```

### Run Hadoop

Feel ready to run Hadoop?

```
$ $HADOOP_HOME/sbin/start-dfs.sh
$ $HADOOP_HOME/sbin/start-yarn.sh
```

If you need to run historyserver as well, run this in xterminal

```
$ $HADOOP_HOME/sbin/mr-jobhistory-daemon.sh --config $HADOOP_HOME/etc/hadoop start historyserver
```

To ensure that all services are running, you can run `jps` command

In `d1`, if you run `jps`, the output will be

```
$ jps
1478 JobHistoryServer
518 NameNode
840 SecondaryNameNode
1018 ResourceManager
1531 Jps
1134 NodeManager
638 DataNode
```

Now try to `ssh d3` and run `jps`. You will get the following output

```
$ jps
294 NodeManager
171 DataNode
431 Jps
```

## Congratulation

You have your Hadoop cluster. Feel free to do anything there. If you need any question, feel free to drop me an email. My email is `arwan.khoiruddin[at]gmail.com`. 

See you there!
