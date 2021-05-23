#!/bin/bash

sudo rm network.py
echo " 
#!/usr/bin/python

import subprocess
import sys
import os
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
    net.addController(name='c0',controller=RemoteController,ip='192.168.10.245', port=6653)

    bw=input("Input bw: ")
    dl=input("Input dl: ")
    ls=int(input("Input ls: "))

    info( '*** Add single switch\n')
    s1 = net.addSwitch('s1')

    info( '*** Add hosts\n')
    h1 = net.addHost('h1')
    h2 = net.addHost('h2')
    h3 = net.addHost('h3')
    h4 = net.addHost('h4')

    info( '*** Add links with QoS parameters\n')
    net.addLink(h1, s1, cls=TCLink, bw=bw, delay=dl, loss=ls)
    net.addLink(h2, s1, cls=TCLink, bw=bw, delay=dl, loss=ls)
    net.addLink(h3, s1, cls=TCLink, bw=bw, delay=dl, loss=ls)
    net.addLink(h4, s1, cls=TCLink, bw=bw, delay=dl, loss=ls)
    
    
    info( '*** Starting network\n')
    net.start()

    CLI(net)
    net.stop()



if __name__ == '__main__':
    setLogLevel( 'info' )
    myNetwork()
" > network.py

sudo chmod +x network.py

