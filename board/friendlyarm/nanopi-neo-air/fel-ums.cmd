# Run by U-Boot when it is loaded over USB with sunxi-fel (FEL mode):
# export the eMMC to the PC as a USB disk, to write emmc.img to it.
echo "NanoPi NEO Air: the eMMC is exported over USB, write emmc.img to it"
ums 0 mmc 1
