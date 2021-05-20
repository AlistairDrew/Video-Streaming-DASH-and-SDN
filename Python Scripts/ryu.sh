#!/bin/bash

sudo apt install python-pip -y

sudo apt-get install python-ryu -y

pip install ryu -y

ryu-manager ryu.app.simple_switch_13 

