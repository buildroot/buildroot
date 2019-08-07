#!/bin/bash
iw dev wlan0 link | awk '/SSID/ {gsub("SSID:", "", $2); print $2}'
