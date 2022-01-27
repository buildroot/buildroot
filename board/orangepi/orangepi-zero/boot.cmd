setenv fdt_high ffffffff

part uuid mmc 0:2 uuid
setenv bootargs console=ttyS0,115200 root=PARTUUID=${uuid} rootwait

fatload mmc 0 $kernel_addr_r zImage
fatload mmc 0 $fdt_addr_r sun8i-h2-plus-orangepi-zero.dtb

bootz $kernel_addr_r - $fdt_addr_r
