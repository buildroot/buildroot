#!/bin/sh

if [ $# -eq 0 ]; then
    echo "No gateware location provided. Checking default location."
    if [ ! -e /lib/firmware/mpfs_bitstream.spi ]; then
        echo "No gateware file found."
        exit 1
    fi
else
    echo "Gateware location provided: $1"
    if [ ! -e "$1"/mpfs_bitstream.spi ]; then
        echo "No gateware file found."
        exit 1
    else
        if [ ! -d /lib/firmware ]; then
            mkdir /lib/firmware
        fi
        cp "$1"/mpfs_dtbo.spi /lib/firmware/mpfs_dtbo.spi
        cp "$1"/mpfs_bitstream.spi /lib/firmware/mpfs_bitstream.spi
    fi
fi

# Trash existing device tree overlay in case the rest of the process fails:
flash_erase /dev/mtd0 0 16

# Initiate FPGA update for dtbo
echo 1 > /sys/class/firmware/mpfs-auto-update/loading

# Write device tree overlay
cat /lib/firmware/mpfs_dtbo.spi > /sys/class/firmware/mpfs-auto-update/data

# Signal completion for dtbo load
echo 0 > /sys/class/firmware/mpfs-auto-update/loading

while [ "$(cat /sys/class/firmware/mpfs-auto-update/status)" != "idle" ]; do
    # Do nothing, just keep checking
    sleep 1
done

# Fake the presence of a golden image for now.
dd if=/dev/zero of=/dev/mtd0 count=1 bs=4

# Initiate FPGA update for bitstream
echo 1 > /sys/class/firmware/mpfs-auto-update/loading

# Write the firmware image to the data sysfs file
cat /lib/firmware/mpfs_bitstream.spi > /sys/class/firmware/mpfs-auto-update/data

# Signal completion for bitstream load
echo 0 > /sys/class/firmware/mpfs-auto-update/loading

while [ "$(cat /sys/class/firmware/mpfs-auto-update/status)" != "idle" ]; do
    # Do nothing, just keep checking
    sleep 1
done

# When the status is 'idle' and no error has occured, reboot the system for
# the gateware update to take effect. FPGA reprogramming takes places between
# Linux shut-down and HSS restarting the board.
if [ "$(cat /sys/class/firmware/mpfs-auto-update/error)" = "" ]; then
    echo "FPGA update ready. Rebooting."
    reboot
else
    echo "FPGA update failed with status: $(cat /sys/class/firmware/mpfs-auto-update/error)"
    exit 1
fi
