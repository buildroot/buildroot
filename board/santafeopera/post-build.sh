#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# Allow root login via OpenSSH if it's configured
if [ -e ${TARGET_DIR}/etc/ssh/sshd_config ]; then
    sed -i '/PermitRootLogin prohibit-password/a\
PermitRootLogin yes' ${TARGET_DIR}/etc/ssh/sshd_config
fi

# Change root's shell to bash if installed
if [ -x ${TARGET_DIR}/bin/bash ]; then
    sed -i 's@^root:.*/bin/sh$@root:x:0:0:root:/root:/bin/bash@' \
    ${TARGET_DIR}/etc/passwd
fi
