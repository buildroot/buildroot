#! /bin/sh

SCRIPT_DIR="$(dirname "$0")"
BR_BASEDIR="$(readlink -e "${SCRIPT_DIR}/../../..")"

# spike uses dtc at runtime startup, so make sure buildroot host
# directory is in the PATH
export PATH="${BR_BASEDIR}/output/host/usr/bin:$PATH"

# Use Buildroot host spike by default, but allow the caller to
# redefine another spike binary
: "${SPIKE:=spike}"

exec "${SPIKE}" \
    --initrd "${BR_BASEDIR}"/output/images/rootfs.cpio \
    "${@}" \
    "${BR_BASEDIR}"/output/images/fw_payload.elf
