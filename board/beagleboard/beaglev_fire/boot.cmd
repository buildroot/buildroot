# this assumes ${scriptaddr} is already set!!

# Try to boot a fitImage from eMMC/SD

setenv fdt_high 0xffffffffffffffff
setenv initrd_high 0xffffffffffffffff

load mmc 0:${distro_bootpart} ${scriptaddr} beaglev_fire.itb;
bootm start ${scriptaddr}#kernel_dtb;
bootm loados ${scriptaddr};
# Try to load a ramdisk if available inside fitImage
bootm ramdisk;
bootm prep;
fdt set /soc/ethernet@20110000 mac-address ${beaglevfire_mac_addr0};
run design_overlays;
bootm go;
