#!/bin/bash

test -f .Xauthority && mv .Xauthority .Xauthority.bak
cp -a /home/adrew/.Xauthority .Xauthority 
chown root: .Xauthority