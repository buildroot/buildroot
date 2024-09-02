#!/bin/sh
echo "Executing script in fakeroot env"
mkdir -p ${TARGET_DIR}/mnt/data
mkdir -p ${TARGET_DIR}/oem/bin/
chmod 755 ${TARGET_DIR}/etc/init.d/S01syslogd