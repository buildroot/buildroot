#!/bin/bash
ifconfig wlan0 | awk '/inet addr/ {gsub("addr:", "", $2); print $2}'