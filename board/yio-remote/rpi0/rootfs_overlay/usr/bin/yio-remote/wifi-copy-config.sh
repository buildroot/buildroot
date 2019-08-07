#!/bin/bash
if [ -e /mnt/boot/wpa_supplicant.conf ]
then
    # stop wifi
    systemctl stop wpa_supplicant@wlan0.service
    sleep 5
    # copy config file
    cp /mnt/boot/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
    sleep 5
    # restart wifi
    systemctl start wpa_supplicant@wlan0.service
    sleep 5
else
    echo "No wpa config."
fi

