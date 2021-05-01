#!/bin/bash

sudo wget 10.224.41.8/bbb/bbb1.mp4
sudo ffmpeg -i bbb1.mp4 -t 00:02:00 bbb1_2m.mp4
sudo wget 10.224.41.8/bbb/dashjs.zip
sudo unzip dashjs.zip
