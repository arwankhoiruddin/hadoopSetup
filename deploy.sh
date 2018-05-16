# update ~/.bashrc
cp ./bashrc ~/.bashrc
exec bash
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
sudo chown -R hduser:hduser /home/hduser/hdfs
echo "directories needed by Hadoop are created"

# copy the files into the desired target
cp ./*.xml /usr/local/hadoop/etc/hadoop/
cp hadoop-env.sh /usr/local/hadoop/etc/hadoop/
cp slaves /usr/local/hadoop/etc/hadoop/
echo "files have been copied. If you are working on master, copy masters into etc/hadoop folder"
