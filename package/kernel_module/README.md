# mipi_dsi

### Features
This is a linux kernel driver for MIPI-DSI panel with touch panel attached to I2C bus.

### How to use
Add these lines to '/boot/config.txt':
```
dtparam=i2c_arm=on
dtparam=i2c_vc=on
ignore_lcd=1
dtoverlay=vc4-kms-v3d-pi4
dtoverlay=mipi_dsi-i2c10
```

Get the mipi_dsi source code, and install all linux kernel drivers:
```bash
git clone https://github.com/Seeed-Studio/seeed-linux-dtoverlays.git
git checkout mipi_dsi
make all_rpi
sudo make install_rpi
sudo reboot
```

You can get these file nodes from sysfs:
```
/sys/bus/mipi-dsi/devices/fe700000.dsi.0/
/dev/input/event0
```

Change Backlight:
```
# use root account
su root
# turn off
echo 0 > /sys/class/backlight/10-0045/brightness
# Half brightness
echo 125 > /sys/class/backlight/10-0045/brightness
# full brightness
echo 255 > /sys/class/backlight/10-0045/brightness
# exit root account
exit
```

Touchpanel Test:
```
$ evtest 
No device specified, trying to scan all of /dev/input/event*
Not running as root, no devices may be available.
Available devices:
/dev/input/event0:      seeed-tp
Select the device event number [0-0]: 0
Input driver version is 1.0.1
Input device ID: bus 0x18 vendor 0x1234 product 0x1001 version 0x100
Input device name: "seeed-tp"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 330 (BTN_TOUCH)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value      0
      Min        0
      Max      480
    Event code 1 (ABS_Y)
      Value      0
      Min        0
      Max      854
    Event code 47 (ABS_MT_SLOT)
      Value      0
      Min        0
      Max        4
    Event code 53 (ABS_MT_POSITION_X)
      Value      0
      Min        0
      Max      480
    Event code 54 (ABS_MT_POSITION_Y)
      Value      0
      Min        0
      Max      854
    Event code 57 (ABS_MT_TRACKING_ID)
      Value      0
      Min        0
      Max    65535
Properties:
  Property type 1 (INPUT_PROP_DIRECT)
Testing ... (interrupt to exit)
Event: time 1608004517.527355, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 0
Event: time 1608004517.527355, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 223
Event: time 1608004517.527355, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 552
Event: time 1608004517.527355, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
Event: time 1608004517.527355, type 3 (EV_ABS), code 0 (ABS_X), value 223
Event: time 1608004517.527355, type 3 (EV_ABS), code 1 (ABS_Y), value 552
Event: time 1608004517.527355, -------------- SYN_REPORT ------------
Event: time 1608004517.557357, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 551
Event: time 1608004517.557357, type 3 (EV_ABS), code 1 (ABS_Y), value 551
Event: time 1608004517.557357, -------------- SYN_REPORT ------------
Event: time 1608004517.685891, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value -1
Event: time 1608004517.685891, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 0
Event: time 1608004517.685891, -------------- SYN_REPORT ------------
```

Enjoy !
