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

git clone https://github.com/mininet/mininet
cd mininet && git fetch
git tag
git checkout -b mininet
sudo apt-get update && sudo apt-get upgrade

sudo sed "s|git clone git://github.com/mininet/openflow|git clone https://github.com/mininet/openflow|" mininet/util/ $


cd
sudo -s
test -f .Xauthority && mv .Xauthority .Xauthority.bak
cp -a /home/adrew/.Xauthority .Xauthority
chown root: .Xauthority

su adrew
cd /var/www/html
wget --no-check-certificate "https://onedrive.live.com/download?cid=F88332955AD48600&resid=F88332955AD48600%21105289&authkey=AKy_cxawQ1QbDmg"