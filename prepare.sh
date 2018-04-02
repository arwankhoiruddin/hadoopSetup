sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install software-properties-common oracle-java8-installer ansible git aptitude firefox openssh-server

mkdir riset
cd riset
curl -O https://gist.githubusercontent.com/arwankhoiruddin/b913b4d87f7ec9617016bc28c9e531a7/raw/5dde11bbdc3161717f07cc73535c5d1fc4b6f983/customDockerNetworkVolume.py
mv customDockerNetworkVolume.py mynet.py

git clone https://github.com/containernet/containernet.git
cd containernet/ansible
sudo ansible-playbook -i "localhost," -c local install.yml

cd ../mininet
curl -O https://raw.githubusercontent.com/arwankhoiruddin/heterodoop/master/mininet/node.py
cd ..
sudo python setup.py install

curl -O http://www-eu.apache.org/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz
tar xvfz hadoop-2.9.0.tar.gz
mv hadoop-2.9.0 hd29

sudo service ssh restart
