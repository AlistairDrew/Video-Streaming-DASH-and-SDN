#!/bin/bash

#Installing packages needed in the environment:

#General management packages
sudo apt-get install openssh-server -y
sudo apt-get install unzip -y
sudo apt-get install curl -y
sudo apt-get install tree -y
sudo apt-get install git -y

#Service packages for webserver hosting and measurement 
sudo apt-get install apache2 -y
sudo apt-get install wireshark-qt

#Segmentation Packages 
sudo apt-get install x264 -y
sudo apt-get install gpac -y
sudo apt-get install ffmpeg -y 

#Installing Mininet 
git clone https://github.com/mininet/mininet
cd mininet && git fetch
git tag
git checkout -b mininet
sudo apt-get update && sudo apt-get upgrade
cd
sudo sed -i "s|git clone git://github.com/mininet/openflow|git clone https://github.com/mininet/openflow|g" mininet/util/install.sh 
sudo mininet/util/install.sh -nfv


#Installing Microsoft Edge 
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm microsoft.gpg
sudo apt update
sudo apt install microsoft-edge-dev

#Pulling resources from Uni server and processing them
cd /var/www/html/
sudo wget 10.224.41.8/bbb/bbb1.mp4
sudo ffmpeg -i bbb1.mp4 -t 00:02:00 bbb1_2m.mp4
sudo wget 10.224.41.8/bbb/dashjs.zip
sudo unzip dashjs.zip

#Encoding and segmenting the video 
sudo x264 --output video_1200k.264 --fps 30 --bitrate 1200 --video-filter resize:width=1280,height=720 bbb1_2m.mp4
sudo MP4Box -add video_1200k.264 -fps 30 video_1200k.mp4
sudo MP4Box -dash 7000 -frag 4000 -rap -segment-name segment_1200k_ video_1200k.mp4

sudo x264 --output video_2400k.264 --fps 30 --bitrate 2400 --video-filter resize:width=1280,height=720 bbb1_2m.mp4
sudo MP4Box -add video_2400k.264 -fps 30 video_2400k.mp4
sudo MP4Box -dash 7000 -frag 4000 -rap -segment-name segment_2400k_ video_2400k.mp4

sudo x264 --output video_600k.264 --fps 30 --bitrate 600 --video-filter resize:width=1280,height=720 bbb1_2m.mp4
sudo MP4Box -add video_600k.264 -fps 30 video_600k.mp4
sudo MP4Box -dash 7000 -frag 4000 -rap -segment-name segment_600k_ video_600k.mp4

#Concatinating the MPD files of different representations into one file
sudo cat video_600k_dash.mpd >> test.mpd
sudo cat video_1200k_dash.mpd >> test.mpd
sudo cat video_2400k_dash.mpd >> test.mpd

#Editing the MPD file line by line so that it removes unnecisary repeated text and aligns the representations. It also changes the ID's so DashJS can differentiate between the representations. 
sudo sed -i '38,48d;77,87d;49 s_id="1"_id="2"_;88 s_id="1"_id="3"_' test.mpd  

#Putting code into Dash that 
sudo sed -i '757 s~^~var totalBuffer = 0;\n var prevBuffer = 0;\n var bufferCounter = 0;\n var totalBitrate =0; \n var bitrateCounter=0;\n~;778 s~^~\nif (bufferLevel != prevBuffer) {\ntotalBuffer = totalBuffer + bufferLevel;\nbufferCounter++;\n }\nprevBuffer = bufferLevel;\n totalBitrate = Bitrate + bitrate;\n bitrateCounter++;\n var meanBuffer = totalBuffer/bufferCounter;\n var meanBitrate = totalBitrate/bitrateCounter;\n  console.log("Mean Bufferlenght: " + meanBuffer.toString() + "Mean Bitrate: " + meanBitrate.toString());~' dashjs/app/main.js

#Creating the Python file for the network topology
cd 
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
    net.addController(name='c0',controller=RemoteController,ip='192.168.10.200', port=6653)

    bw=input("Input bw: ")
    dl=input("Input dl: ")
    ls=input("Input ls: ")

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





