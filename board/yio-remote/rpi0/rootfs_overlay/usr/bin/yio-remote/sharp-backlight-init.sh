#!/bin/bash
fbv -d 1 /usr/bin/yio-remote/images/splash.png
gpio -g mode 12 pwm
gpio pwm-ms
gpio pwmc 1000
gpio pwmr 100
gpio -g pwm 12 100

/usr/bin/tvservice -o
echo none | tee /sys/class/leds/led0/trigger
echo 1 | tee /sys/class/leds/led0/brightness
