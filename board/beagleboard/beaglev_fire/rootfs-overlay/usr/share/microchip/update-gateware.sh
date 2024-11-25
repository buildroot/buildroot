#!/bin/sh

if [ ! -e "$1"/mpfs_bitstream.spi ]; then
        echo "No gateware file found."
        exit 1
fi

if [ ! -d /lib/firmware ]
then
    mkdir /lib/firmware
fi

cp "$1"/mpfs_dtbo.spi /lib/firmware/mpfs_dtbo.spi
cp "$1"/mpfs_bitstream.spi /lib/firmware/mpfs_bitstream.spi

mount -t debugfs none /sys/kernel/debug

# Trash existing device tree overlay in case the rest of the process fails:
flash_erase /dev/mtd0 0 1024

# # Write device tree overlay
dd if=/lib/firmware/mpfs_dtbo.spi of=/dev/mtd0 seek=1024

# Fake the presence of a golden image for now.
dd if=/dev/zero of=/dev/mtd0 count=4 bs=1

# Initiate FPGA update.
echo 1 > /sys/kernel/debug/fpga/microchip_exec_update

# Reboot Linux for the gateware update to take effect.
# FPGA reprogramming takes places between Linux shut-down and HSS restarting the board.
reboot
