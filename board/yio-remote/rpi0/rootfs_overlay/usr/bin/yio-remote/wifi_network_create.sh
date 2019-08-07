#!/bin/bash

#check if there is a file
if [ -e /etc/wpa_supplicant/wpa_supplicant-wlan0.conf ]; then

    # delete existing configuration file
    rm -rf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf

    # create a configuration file
    echo "ctrl_interface=/var/run/wpa_supplicant
ap_scan=1

network={
    key_mgmt=WPA-PSK
    ssid="\"$1\""
    psk="\"$2\""
}" >> /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
else
    # create a configuration file
    echo "ctrl_interface=/var/run/wpa_supplicant
ap_scan=1
    
network={
    key_mgmt=WPA-PSK
    ssid="\"$1\""
    psk="\"$2\""
}" >> /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
fi