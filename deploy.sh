# install jdk8
# sudo add-apt-repository ppa:webupd8team/java
# sudo apt-get update
# sudo apt-get install oracle-java8-installer

# update ~/.bashrc
cp ./bashrc ~/.bashrc
source ~/.bashrc
echo "bashrc updated"

# update /etc/hosts
cp ./hosts /etc/hosts
echo "/etc/hosts is updated"

# disable ipv6
sudo cp ./sysctl.conf /etc/sysctl.conf
sudo sysctl -p
echo "ipv6 disabled"

# make folders for datanode, namenode and temporary
mkdir -p /home/hduser/hdfs/tmp
mkdir -p /home/hduser/hdfs/datanode
mkdir -p /home/hduser/hdfs/namenode
echo "directories needed by Hadoop are created"

# copy the files into the desired target
cp ./*.xml ../hd29/etc/hadoop/
cp hadoop-env.sh ../hd29/etc/hadoop/
cp slaves ../hd29/etc/hadoop/
echo "files have been copied. If you are working on master, copy masters into etc/hadoop folder"
