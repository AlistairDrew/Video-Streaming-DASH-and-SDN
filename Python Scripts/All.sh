sudo apt-get install tree -y
sudo apt-get install apache2 -y
sudo apt-get install x264 -y
sudo apt-get install gpac -y
sudo apt-get install ffmpeg -y 

git clone https://github.com/mininet/mininet
cd mininet && git fetch
git tag
git checkout -b mininet
sudo apt-get update && sudo apt-get upgrade

sudo sed -i "s|git clone git://github.com/mininet/openflow|git clone https://github.com/mininet/openflow|g" mininet/util/install.sh 



cd
sudo mininet/util/install.sh -nfv



curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm microsoft.gpg
sudo apt update
sudo apt install microsoft-edge-dev

sudo wget 10.224.41.8/bbb/bbb1.mp4
sudo ffmpeg -i bbb1.mp4 -t 00:02:00 bbb1_2m.mp4
sudo wget 10.224.41.8/bbb/dashjs.zip
sudo unzip dashjs.zip


sudo x264 --output video_1200k.264 --fps 30 --bitrate 1200 --video-filter resize:width=1280,height=720 bbb1_2m.mp4
sudo MP4Box -add video_1200k.264 -fps 30 video_1200k.mp4
sudo MP4Box -dash 7000 -frag 4000 -rap -segment-name segment_1200k_ video_1200k.mp4

sudo x264 --output video_2400k.264 --fps 30 --bitrate 2400 --video-filter resize:width=1280,height=720 bbb1_2m.mp4
sudo MP4Box -add video_2400k.264 -fps 30 video_2400k.mp4
sudo MP4Box -dash 7000 -frag 4000 -rap -segment-name segment_2400k_ video_2400k.mp4

sudo x264 --output video_600k.264 --fps 30 --bitrate 600 --video-filter resize:width=1280,height=720 bbb1_2m.mp4
sudo MP4Box -add video_600k.264 -fps 30 video_600k.mp4
sudo MP4Box -dash 7000 -frag 4000 -rap -segment-name segment_600k_ video_600k.mp4


sudo cat video_600k_dash.mpd >> test.mpd
sudo cat video_1200k_dash.mpd >> test.mpd
sudo cat video_2400k_dash.mpd >> test.mpd

sudo nano network.py



su adrew

