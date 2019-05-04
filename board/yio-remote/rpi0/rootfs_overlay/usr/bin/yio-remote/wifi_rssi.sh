#!/bin/bash
wpa_cli signal_poll | grep "RSSI=" | cut -c6-