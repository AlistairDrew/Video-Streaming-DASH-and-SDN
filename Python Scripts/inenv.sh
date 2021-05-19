#!/bin/bash

sudo apt-get install openssh-server
sudo apt-get install git
sudo apt-get install firefox
sudo apt-get install -y unzip
sudo apt-get install curl
sudo apt-get install wireshark
sudo apt-get install tree
sudo apt-get install apache2
sudo apt-get install x264
sudo apt-get install gpac
sudo apt-get install ffmpeg 

git clone https://github.com/mininet/mininet
cd mininet && git fetch
git tag
git checkout -b mininet
sudo apt-get update && sudo apt-get upgrade

sudo sed -i "s|git clone git://github.com/mininet/openflow|git clone https://github.com/mininet/openflow|g" mininet/util/install.sh 



cd
sudo mininet/util/install.sh -nfv

sudo -s
test -f .Xauthority && mv .Xauthority .Xauthority.bak
cp -a /home/adrew/.Xauthority .Xauthority
chown root: .Xauthority

su adrew

