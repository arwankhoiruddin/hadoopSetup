sudo apt-get update
sudo apt-get install -y software-properties-common ansible git aptitude firefox openssh-server openjdk-8-jdk openjdk-8-jre derby-tools python3-pip 

cd ..
mkdir study
cd study
curl -O https://gist.githubusercontent.com/arwankhoiruddin/36a2bc0b30c60a4101ebed0e6f5d0c3d/raw/ceb9877f716179250508e46b2001e1d8a123e309/singleRackContainernet.py
mv singleRackContainernet.py mynet.py
chmod +x mynet.py

git clone https://github.com/containernet/containernet.git
cd containernet/ansible
sudo ansible-playbook -i "localhost," -c local install.yml
cd ..
sudo make develop

sudo groupadd docker
sudo gpasswd -a $USER docker

sudo docker pull arwankhoiruddin/heterodoop

pip install docker

cd ..
curl -O https://archive.apache.org/dist/hadoop/core/hadoop-2.9.1/hadoop-2.9.1.tar.gz
tar xvfz hadoop-2.9.1.tar.gz
mv hadoop-2.9.1 hd29
rm hadoop-2.9.1.tar.gz
