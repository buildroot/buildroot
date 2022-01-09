#! /bin/sh

SCRIPT_DIR="$(dirname "$0")"
BR_BASEDIR="$(readlink -e "${SCRIPT_DIR}/../../..")"

# Use Buildroot host spike by default, but allow the caller to
# redefine another spike binary
: "${SPIKE:=${BR_BASEDIR}/output/host/usr/bin/spike}"

exec "${SPIKE}" \
    --initrd "${BR_BASEDIR}"/output/images/rootfs.cpio \
    "${@}" \
    "${BR_BASEDIR}"/output/images/fw_payload.elf
