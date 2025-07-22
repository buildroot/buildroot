fdt addr ${fdtcontroladdr}
fdt resize

fdt set /chosen \#address-cells <1>
fdt set /chosen \#size-cells <1>

fdt mknod /chosen modules

fdt mknod /chosen/modules module@0
fdt set /chosen/modules/module@0 compatible "xen,linux-zimage" "xen,multiboot-module"
load ${devtype} ${devnum} ${kernel_addr_r} zImage
fdt set /chosen/modules/module@0 reg <${kernel_addr_r} 0x${filesize} >

fdt mknod /chosen/modules module@1
fdt set /chosen/modules/module@1 compatible "xen,linux-initrd" "xen,multiboot-module"
load ${devtype} ${devnum} ${ramdisk_addr_r} rootfs.cpio
fdt set /chosen/modules/module@1 reg <${ramdisk_addr_r} 0x${filesize} >

load ${devtype} ${devnum} ${loadaddr} xen
fdt set /chosen xen,dom0-bootargs "console=hvc0"
fdt set /chosen xen,xen-bootargs "dom0_mem=256M loglvl=all guest_loglvl=all"
fdt print /chosen
bootz ${loadaddr} - ${fdtcontroladdr}
