#!/usr/bin/python

from mininet.net import Mininet
from mininet.node import Controller
from mininet.cli import CLI
from mininet.link import TCLink
from mininet.log import setLogLevel, info
from mininet.node import OVSKernelSwitch, RemoteController

def myNetwork():

    net = Mininet( topo=None,
                   build=False)

    info( '*** Adding controller\n' )
    net.addController(name='c0',controller=RemoteController,ip='192.168.10.200', port=6653)

    info( '*** Add single switch\n')
    s1 = net.addSwitch('s1')

    info( '*** Add hosts\n')
    h1 = net.addHost('h1')
    h2 = net.addHost('h2')
    h3 = net.addHost('h3')

    info( '*** Add links with QoS parameters\n')
    net.addLink(h1, s1, cls=TCLink, bw=1000, delay='1ms', loss=0)
    net.addLink(h2, s1, cls=TCLink, bw=1000, delay='1ms', loss=5)
    net.addLink(h3, s1, cls=TCLink, bw=1000, delay='1ms', loss=5)
    

    info( '*** Starting network\n')
    net.start()

    CLI(net)
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    myNetwork()
