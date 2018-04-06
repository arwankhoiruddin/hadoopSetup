sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer ansible git aptitude firefox openssh-server

cd ..
mkdir riset
cd riset
curl -O https://gist.githubusercontent.com/arwankhoiruddin/b913b4d87f7ec9617016bc28c9e531a7/raw/cfe35f3595418a14ae25db205ecd1c83af3825e4/customDockerNetworkVolume.py
mv customDockerNetworkVolume.py mynet.py
chmod +x mynet.py

git clone https://github.com/containernet/containernet.git
cd containernet/ansible
sudo ansible-playbook -i "localhost," -c local install.yml

cd ../mininet
curl -O https://raw.githubusercontent.com/arwankhoiruddin/heterodoop/master/mininet/node.py
cd ..
sudo python setup.py install

cd ..
curl -O http://www-eu.apache.org/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz
tar xvfz hadoop-2.9.0.tar.gz
mv hadoop-2.9.0 hd29
rm hadoop-2.9.0.tar.gz

sudo service ssh restart
