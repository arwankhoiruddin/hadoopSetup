import random

def writeLine(f, str):
    f.write(str + '\n')


# This script will generate single rack Hadoop

numNode = 5
homogenous = True

with open('node.py','w') as f:
    writeLine(f, '#!/usr/bin/python')
    writeLine(f, "")

    writeLine(f, 'from mininet.net import Containernet')
    writeLine(f, 'from mininet.node import Controller')
    writeLine(f, 'from mininet.cli import CLI')
    writeLine(f, 'from mininet.link import TCLink')
    writeLine(f, 'from mininet.log import info, setLogLevel')
    writeLine(f, "setLogLevel('info')")
    writeLine(f, "")

    writeLine(f, 'net = Containernet(controller=Controller)')
    writeLine(f, "")

    writeLine(f, "info('*** Adding controller ***')")
    writeLine(f, "net.addController('c0')")
    writeLine(f, "vol = ['/root/hadoopSetup:/hadoopSetup','/root/research/hd29:/usr/local/hadoop']")
    writeLine(f, "hdimage = 'arwankhoiruddin/heterodoop'")
    writeLine(f, "")

    writeLine(f, "info('*** Adding docker containers ***')")

    startIP = 1
    for i in range(numNode):
        node = "d" + str(i)
        ip = "10.0.0." + str(startIP + i)
        if homogenous:
            ncpu = '1'
        else:
            ncpu = str(random.random())
        writeLine(f, node + "= net.addDocker('"+ node +"', ip='"+ip+"', cpu=" + ncpu+ ", volumes=vol, dimage=hdimage)")

    writeLine(f, "")
    writeLine(f, "info('*** Adding switch ***')")
    writeLine(f, "s1 = net.addSwitch('s1')")
    writeLine(f, "")

    writeLine(f, "info('*** Adding links ***')")
    for i in range(numNode):
        node = "d" + str(i)
        writeLine(f, "net.addLinks(" + node + ", s1)")

    writeLine(f, "")
    writeLine(f, "info('*** Starting network ***')")
    writeLine(f, "net.start()")

    writeLine(f, "")
    writeLine(f, "info('*** Testing connectivity ***')")
    writeLine(f, "net.pingAll()")

    writeLine(f, "")
    writeLine(f, "info('*** Running CLI ***')")
    writeLine(f, "CLI(net)")

    writeLine(f, "")
    writeLine(f, "info('*** Stopping network')")
    writeLine(f, "net.stop()")
