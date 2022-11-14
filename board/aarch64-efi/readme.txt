
The aarch64_efi_defconfig allows to build a minimal Linux system that
can boot on all AArch64 servers providing an EFI firmware.

This includes all Arm EBBR[1] compliant systems, and all Arm SystemReady[2]
compliant systems for example.


Building and booting
====================

$ make aarch64_efi_defconfig
$ make

The file output/images/disk.img is a complete disk image that can be
booted, it includes the grub2 bootloader, Linux kernel and root
filesystem.

Testing under Qemu
==================

This image can also be tested using Qemu:

qemu-system-aarch64 \
	-M virt \
	-cpu cortex-a57 \
	-m 512 \
	-nographic \
	-bios </path/to/QEMU_EFI.fd> \
	-drive file=output/images/disk.img,if=none,format=raw,id=hd0 \
	-device virtio-blk-device,drive=hd0 \
	-netdev user,id=eth0 \
	-device virtio-net-device,netdev=eth0

Note that </path/to/QEMU_EFI.fd> needs to point to a valid aarch64 UEFI
firmware image for qemu.
It may be provided by your distribution as a edk2-aarch64 or AAVMF
package, in path such as /usr/share/edk2/aarch64/QEMU_EFI.fd .

U-Boot based qemu firmware
==========================

A qemu firmware with support for UEFI based on U-Boot can be built following
the instructions in [3], with qemu_arm64_defconfig.

This should give you a nor_flash.bin, which you can use with qemu as an
alternative to QEMU_EFI.fd. You will also need to change the machine
specification to "-M virt,secure=on" on qemu command line, to enable TrustZone
support, and you will need to increase the memory with "-m 1024".

[1]: https://github.com/ARM-software/ebbr
[2]: https://developer.arm.com/architectures/system-architectures/arm-systemready
[3]: https://github.com/glikely/u-boot-tfa-build
