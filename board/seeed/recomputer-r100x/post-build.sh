#!/bin/sh

set -u
set -e

#modify the config.txt
CFG_PATH=${BINARIES_DIR}/rpi-firmware/config.txt
grep -q "^dtparam=i2c_arm=on$" $CFG_PATH || echo "dtparam=i2c_arm=on" >> $CFG_PATH
grep -q "^enable_uart=1$" $CFG_PATH || echo "enable_uart=1" >> $CFG_PATH
grep -q "^dtoverlay=i2c1,pins_44_45$" $CFG_PATH || echo "dtoverlay=i2c1,pins_44_45" >> $CFG_PATH
grep -q "^dtoverlay=i2c3,pins_2_3$" $CFG_PATH || echo "dtoverlay=i2c3,pins_2_3" >> $CFG_PATH
grep -q "^dtoverlay=i2c6,pins_22_23$" $CFG_PATH || echo "dtoverlay=i2c6,pins_22_23" >> $CFG_PATH
grep -q "^dtoverlay=reComputer-R100x,uart2$" $CFG_PATH || echo "dtoverlay=reComputer-R100x,uart2" >> $CFG_PATH

