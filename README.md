# Hadoop Setup
This repository provides some basic setup for Multi-Node Hadoop cluster. The repository is based on Michael-Noll's tutorial, with some adjustments.

# Before You Start
After you do some steps below, you can just execute `deploy.sh` to automagically setup your Hadoop cluster.

So, before you start, please do the following steps:

### Install the packages needed
```
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
```

### Update `/etc/hosts`

Remove all lines in `/etc/hosts` and put all the connected computers. For example, your Hadoop cluster will contain three computers with IP address `192.168.0.100` as `master`, `192.168.0.101` as `slave1`, and `192.168.0.102` as `slave2`. 

In all those computers, edit your `/etc/hosts` as follows

```
192.168.0.100		master
192.168.0.101		slave1
192.168.0.102		slave2
```
If you have `127.0.1.1` in your `hosts`, remove that line

### Prepare SSH Access from master to all slaves

The `hduser` of `master` computer must be able to connect to its own using `ssh master` as well as connecting to all slaves using `ssh slave1` and `ssh slave2` using password-less SSH login. Do the following steps:

```
hduser@master:~$ ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@master
hduser@master:~$ ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@slave1
hduser@master:~$ ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@slave2
```

Then test your connection

```
hduser@master:~$ ssh master
hduser@master:~$ ssh slave1
hduser@master:~$ ssh slave2
```
For each step above, you will be prompted to save the fingerprint to `master`'s `known_hosts` file. Type `yes` when prompted. See example below

```
hduser@master:~$ ssh master
The authenticity of host 'master (192.168.0.100)' can't be established.
RSA key fingerprint is 3b:21:b3:c0:21:5c:7c:54:2f:1e:2d:96:79:eb:7f:95.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'master' (RSA) to the list of known hosts.
Linux master 2.6.20-16-386 #2 Thu Jun 7 20:16:13 UTC 2007 i686
...
hduser@master:~$
```

### Update `~/.bashrc` in all nodes (master and slaves)

Add the following lines in `~/.bashrc`

```
# Set Hadoop-related environment variables
export HADOOP_HOME=/usr/local/hadoop

# Set JAVA_HOME (we will also configure JAVA_HOME directly for Hadoop later on)
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# Some convenient aliases and functions for running Hadoop-related commands
unalias fs &> /dev/null
alias fs="hadoop fs"
unalias hls &> /dev/null
alias hls="fs -ls"

# If you have LZO compression enabled in your Hadoop cluster and
# compress job outputs with LZOP (not covered in this tutorial):
# Conveniently inspect an LZOP compressed file from the command
# line; run via:
#
# $ lzohead /hdfs/path/to/lzop/compressed/file.lzo
#
# Requires installed 'lzop' command.
#
lzohead () {
    hadoop fs -cat $1 | lzop -dc | head -1000 | less
}

# Add Hadoop bin/ directory to PATH
export PATH=$PATH:$HADOOP_HOME/bin
```

Then reload the `bashrc` using the following command

```
hduser@master:~$ source ~/.bashrc
```

# To be continued
