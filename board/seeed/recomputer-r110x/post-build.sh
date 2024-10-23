#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
# systemd doesn't use /etc/inittab, enable getty.tty1.service instead
elif [ -d ${TARGET_DIR}/etc/systemd ]; then
    mkdir -p "${TARGET_DIR}/etc/systemd/system/getty.target.wants"
    ln -sf /lib/systemd/system/getty@.service \
       "${TARGET_DIR}/etc/systemd/system/getty.target.wants/getty@tty1.service"
fi


#modify the config.txt
CFG_PATH=${BINARIES_DIR}/rpi-firmware/config.txt
grep -q "^enable_uart=1$" $CFG_PATH || echo "enable_uart=1" >> $CFG_PATH
grep -q "^dtoverlay=reComputer-R110x$" $CFG_PATH || echo "dtoverlay=reComputer-R110x" >> $CFG_PATH
grep -q "^gpu_mem=128$" $CFG_PATH || echo "gpu_mem=128" >> $CFG_PATH

#create dir /boot/
if [ ! -d "${TARGET_DIR}/boot/" ]; then
	mkdir ${TARGET_DIR}/boot/
fi

#modify the /etc/fstab
FSTAB_PATH=${TARGET_DIR}/etc/fstab
grep -q "^/dev/mmcblk0p1          /boot           vfat    defaults        0       0$" $FSTAB_PATH \
	|| echo "/dev/mmcblk0p1          /boot           vfat    defaults        0       0" >> \
	$FSTAB_PATH

#modify the /etc/profile
PROFILE_PATH=${TARGET_DIR}/etc/profile
grep -q "^export PS1=" $PROFILE_PATH || echo "export PS1='\u@\h:\w\\$ '" >> $PROFILE_PATH