#!/bin/sh

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"

# BOARD_DIR: board/ammolytics/opentrickler
echo "BOARD_DIR: ${BOARD_DIR}"
# BOARD_NAME: opentrickler
echo "BOARD_NAME: ${BOARD_NAME}"

# BR2_CONFIG: /home/eric/src/ammolytics/opentrickler-buildroot/.config
echo "BR2_CONFIG: ${BR2_CONFIG}"
# CONFIG_DIR: /home/eric/src/ammolytics/opentrickler-buildroot
echo "CONFIG_DIR: ${CONFIG_DIR}"
# HOST_DIR: /home/eric/src/ammolytics/opentrickler-buildroot/output/host
echo "HOST_DIR: ${HOST_DIR}"
# STAGING_DIR: /home/eric/src/ammolytics/opentrickler-buildroot/output/host/arm-buildroot-linux-gnueabihf/sysroot
echo "STAGING_DIR: ${STAGING_DIR}"
# TARGET_DIR: /home/eric/src/ammolytics/opentrickler-buildroot/output/build/buildroot-fs/ext2/target
echo "TARGET_DIR: ${TARGET_DIR}"
# BUILD_DIR: /home/eric/src/ammolytics/opentrickler-buildroot/output/build
echo "BUILD_DIR: ${BUILD_DIR}"
# BINARIES_DIR: /home/eric/src/ammolytics/opentrickler-buildroot/output/images
echo "BINARIES_DIR: ${BINARIES_DIR}"
# BASE_DIR: /home/eric/src/ammolytics/opentrickler-buildroot/output
echo "BASE_DIR: ${BASE_DIR}"



which python3 || true
python3 --version || true
python3 -m ensurepip --upgrade || true
which pip3 || true
pip3 --version || true
python3 -m pip --version || true

echo "`ls -al ${TARGET_DIR}/code`"

python3 -m venv ${TARGET_DIR}/code/venv

# Activate new python venv
. ${TARGET_DIR}/code/venv/bin/activate

which python || true
python --version || true
python -m ensurepip --upgrade || true
which pip || true
pip install --upgrade pip
pip install wheel
pip install bluezero pybleno pyserial gpiozero pymemcache RPi.GPIO grpcio

# Deactivate new python venv
deactivate

echo "`ls -al ${TARGET_DIR}/code/venv/bin`"
echo "`ls -al ${TARGET_DIR}/code/venv/lib/python3.10/site-packages`"

cp -r ${TARGET_DIR}/code/venv ${BINARIES_DIR}/
