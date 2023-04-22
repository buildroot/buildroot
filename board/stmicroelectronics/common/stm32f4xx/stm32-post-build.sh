#!/bin/sh

# Kernel is built without devpts support
sed -i '/^devpts/d' ${TARGET_DIR}/etc/fstab
