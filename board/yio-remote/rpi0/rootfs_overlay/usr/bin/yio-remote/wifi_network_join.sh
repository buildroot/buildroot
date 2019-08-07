#!/bin/bash

# stop wifi
systemctl stop wpa_supplicant@wlan0.service
sleep 5
# restart wifi
systemctl start wpa_supplicant@wlan0.service
sleep 5
# check if connection was succcesful
sleep 5 