# install jdk8
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

# update ~/.bashrc
cp ./bashrc ~/.bashrc

# disable ipv6
sudo cp ./sysctl.conf /etc/sysctl.conf
sudo sysctl -p

# make folders for datanode, namenode and temporary
mkdir -p /home/hduser/hdfs/tmp
mkdir -p /home/hduser/hdfs/datanode
mkdir -p /home/hduser/hdfs/namenode

# copy files into the desired target
echo "now you can edit and run ./copyconf.sh to copy the configurations into your hadoop"
