#!/usr/bin/python3
"""
Create heterogeneous Hadoop cluster
Contains of 4 nodes in two different racks
"""
from mininet.net import Containernet
from mininet.node import Controller
from mininet.cli import CLI
from mininet.link import TCLink
from mininet.log import info, setLogLevel
setLogLevel('info')
import os
import sys

num_nodes = int(sys.argv[1])

# remove all containers if it previously created
for i in range(num_nodes):
    os.system('docker rm --force mn.d' + str(i))

net = Containernet(controller=Controller)

info('*** Adding controller\n')
net.addController('c0')

vol = []
vol.append('/root/hadoopWordCount:/home/hduser/hadoopWordCount')
vol.append('/root/fphadoop-setup:/hadoopSetup')
vol.append('/root/study/hd112:/usr/local/hadoop')

hdimage = "arwankhoiruddin/heterodoop"

info('*** Adding switches\n')
s1 = net.addSwitch('s1')

info('*** Adding docker containers n links \n')
for i in range(num_nodes):
    d = net.addDocker('d'+str(i), ip='10.0.0.25'+str(i), cpu=1, volumes=vol, dimage=hdimage)
    net.addLink(d, s1)

info('*** Starting network\n')
net.start()

info('*** Testing connectivity\n')
net.pingAll()

info('*** Running CLI\n')
CLI(net)

info('*** Stopping network')
net.stop()
