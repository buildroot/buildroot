#!/bin/bash
mount /dev/mmcblk0p1 /mnt/boot
export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS=/dev/input/event0:rotate=90:invertx
/usr/bin/yio-remote/remote &
#sleep 5
#/usr/bin/standby_control.py &
#sleep 4
#/usr/bin/battery.py -l &
