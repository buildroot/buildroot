#! /bin/sh

SCRIPT_DIR="$(dirname "$0")"
BR_BASEDIR="$(readlink -e "${SCRIPT_DIR}/../../..")"

# spike uses dtc at runtime startup, so make sure buildroot host
# directory is in the PATH
export PATH="${BR_BASEDIR}/output/host/usr/bin:$PATH"

# Use Buildroot host spike by default, but allow the caller to
# redefine another spike binary
: "${SPIKE:=spike}"

# Note 1: Kernel with initrd fail to boot on riscv32 when the system
# has more than 1GB of RAM. So we set exactly this amount of RAM.
# Note 2: The default spike ISA is RV64IMAFDC_zicntr_zihpm, so we need
# to force the RV32 ISA here.
exec "${SPIKE}" \
    -m1024 \
    --initrd "${BR_BASEDIR}"/output/images/rootfs.cpio \
    --isa="RV32IMAFDC_zicntr_zihpm" \
    "${@}" \
    "${BR_BASEDIR}"/output/images/fw_payload.elf
