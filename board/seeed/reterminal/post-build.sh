#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

#copy the dtoverlay file
cp ${BUILD_DIR}/linux-custom/arch/arm/boot/dts/overlays/reTerminal.dtbo ${BINARIES_DIR}/rpi-firmware/overlays/

#modify the config.txt
CFG_PATH=${BINARIES_DIR}/rpi-firmware/config.txt
grep -q "^dtparam=i2c_arm=on$" $CFG_PATH || echo "dtparam=i2c_arm=on" >> $CFG_PATH
grep -q "^dtoverlay=vc4-fkms-v3d$" $CFG_PATH || echo "dtoverlay=vc4-fkms-v3d" >> $CFG_PATH
grep -q "^max_framebuffers=2$" $CFG_PATH || echo "max_framebuffers=2" >> $CFG_PATH
grep -q "^enable_uart=1$" $CFG_PATH || echo "enable_uart=1" >> $CFG_PATH
grep -q "^dtoverlay=dwc2,dr_mode=host$" $CFG_PATH || echo "dtoverlay=dwc2,dr_mode=host" >> $CFG_PATH
grep -q "^dtparam=ant2$" $CFG_PATH || echo "dtparam=ant2" >> $CFG_PATH
grep -q "^disable_splash=1$" $CFG_PATH || echo "disable_splash=1" >> $CFG_PATH
grep -q "^ignore_lcd=1$" $CFG_PATH || echo "ignore_lcd=1" >> $CFG_PATH
grep -q "^dtoverlay=vc4-kms-v3d-pi4$" $CFG_PATH || echo "dtoverlay=vc4-kms-v3d-pi4" >> $CFG_PATH
grep -q "^dtoverlay=i2c3,pins_4_5$" $CFG_PATH || echo "dtoverlay=i2c3,pins_4_5" >> $CFG_PATH
grep -q "^gpio=13=pu$" $CFG_PATH || echo "gpio=13=pu" >> $CFG_PATH
grep -q "^dtoverlay=reTerminal$" $CFG_PATH || echo "dtoverlay=reTerminal" >> $CFG_PATH
grep -q "^dtoverlay=miniuart-bt$" $CFG_PATH || echo "dtoverlay=miniuart-bt" >> $CFG_PATH

#create dir /boot/
if [ ! -d "${TARGET_DIR}/boot/" ]; then
	mkdir ${TARGET_DIR}/boot/
fi

#modify the /etc/fstab
FSTAB_PATH=${TARGET_DIR}/etc/fstab
grep -q "^/dev/mmcblk0p1          /boot           vfat    defaults        0       0$" $FSTAB_PATH \
	|| echo "/dev/mmcblk0p1          /boot           vfat    defaults        0       0" >> \
	$FSTAB_PATH
