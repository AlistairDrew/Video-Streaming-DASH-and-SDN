#!/bin/bash

sudo x264 --output video_1200k.264 --fps 30 --bitrate 1200 --video-filter resize:width=1280,height=720 bbb1_2m.mp4
sudo MP4Box -add video_1200k.264 -fps 30 video_1200k.mp4
sudo MP4Box -dash 7000 -frag 4000 -rap -segment-name segment_1200k_ video_1200k.mp4

sudo x264 --output video_2400k.264 --fps 30 --bitrate 2400 --video-filter resize:width=1280,height=720 bbb1_2m.mp4
sudo MP4Box -add video_2400k.264 -fps 30 video_2400k.mp4
sudo MP4Box -dash 4000 -frag 4000 -rap -segment-name segment_2400k_ video_2400k.mp4

sudo x264 --output video_600k.264 --fps 30 --bitrate 600 --video-filter resize:width=1280,height=720 bbb1_2m.mp4
sudo MP4Box -add video_600k.264 -fps 30 video_600k.mp4
sudo MP4Box -dash 4000 -frag 4000 -rap -segment-name segment_600k_ video_600k.mp4

sudo -s
cat video_600k_dash.mpd >> test.mpd
cat video_1200k_dash.mpd >> test.mpd
cat video_2400k_dash.mpd >> test.mpd
sudo su (adrew)




