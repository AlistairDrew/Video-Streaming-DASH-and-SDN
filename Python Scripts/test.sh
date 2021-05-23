#!/bin/bash

apache2ctl -k stop
apache2ctl -k stop 
apache2ctl -k stop 
apache2ctl -k start
netstat -ltn

