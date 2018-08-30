#!/bin/sh

# the other option is linuxfb if just using qt widgets
export QT_QPA_PLATFORM=eglfs

# if using tslib
#export QT_QPA_FB_TSLIB=1
#export TSLIB_FBDEVICE=/dev/fb0
#export TSLIB_TSDEVICE=/dev/input/touchscreen0

# physical width and height units are mm

# for the official Pi 7" touchscreen
#export QT_QPA_EGLFS_PHYSICAL_WIDTH=155
#export QT_QPA_EGLFS_PHYSICAL_HEIGHT=86
#export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS=/dev/input/touchscreen0:rotate=180

# for the pitft35r 480x320 touchscreen
#export QT_QPA_EGLFS_WIDTH=480
#export QT_QPA_EGLFS_HEIGHT=320
#export QT_QPA_EGLFS_PHYSICAL_WIDTH=85
#export QT_QPA_EGLFS_PHYSICAL_HEIGHT=50
# set a rotate value appropriate with the one used in the overlay
#export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS=/dev/input/touchscreen0:rotate=90

# for the pitft28r 320x240 touchscreen
#export QT_QPA_EGLFS_WIDTH=320
#export QT_QPA_EGLFS_HEIGHT=240
#export QT_QPA_EGLFS_PHYSICAL_WIDTH=78
#export QT_QPA_EGLFS_PHYSICAL_HEIGHT=50
# set a rotate value appropriate with the one used in the overlay
#export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS=/dev/input/touchscreen0:rotate=90

#############################
# For the Santa Fe Opera Carrier Board
#
export QT_QPA_EGLFS_WIDTH=1280
export QT_QPA_EGLFS_HEIGHT=320
export QT_QPA_EGLFS_PHYSICAL_WIDTH=216
export QT_QPA_EGLFS_PHYSICAL_HEIGHT=54
