sudo apt-get update
sudo apt-get install software-properties-common ansible git aptitude firefox openssh-server

sudo mkdir /usr/lib/jvm
cd /usr/lib/jvm
sudo tar -xvzf /root/hadoopSetup/jdk-8u221-linux-x64.tar.gz
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_221/bin/java" 0
sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_221/bin/javac" 0
sudo update-alternatives --set java /usr/lib/jvm/jdk1.8.0_221/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/jdk1.8.0_221/bin/javac


cd ..
mkdir research
cd research
curl -O https://gist.githubusercontent.com/arwankhoiruddin/36a2bc0b30c60a4101ebed0e6f5d0c3d/raw/ceb9877f716179250508e46b2001e1d8a123e309/singleRackContainernet.py
mv singleRackContainernet.py mynet.py
chmod +x mynet.py

git clone https://github.com/containernet/containernet.git
cd containernet/ansible
sudo ansible-playbook -i "localhost," -c local install.yml

sudo groupadd docker
sudo gpasswd -a $USER docker

docker pull arwankhoiruddin/heterodoop

cd ../mininet
curl -O https://raw.githubusercontent.com/arwankhoiruddin/heterodoop/master/mininet/node.py
cd ..
sudo python setup.py install

cd ..
curl -O http://www-us.apache.org/dist/hadoop/common/hadoop-2.9.1/hadoop-2.9.1.tar.gz
tar xvfz hadoop-2.9.1.tar.gz
mv hadoop-2.9.1 hd29
rm hadoop-2.9.1.tar.gz
