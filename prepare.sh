sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install software-properties-common oracle-java8-installer ansible git aptitude firefox openssh-server

cd ..
mkdir research
cd research
curl -O https://gist.githubusercontent.com/arwankhoiruddin/36a2bc0b30c60a4101ebed0e6f5d0c3d/raw/15a33e218c8581c81e39f930be5802fc2878f3a2/singleRackContainernet.py
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
curl -O http://www-eu.apache.org/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz
tar xvfz hadoop-2.9.0.tar.gz
mv hadoop-2.9.0 hd29
rm hadoop-2.9.0.tar.gz
