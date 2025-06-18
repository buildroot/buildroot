The loongarch64_efi_defconfig allows to build a minimal Linux system that
can boot on all loongarch64 systems providing an New World [1] EFI firmware.

This includes almost all LoongArch Loongson-3 series workstations and servers,
see [2] for hardware and firmware information.

Building and booting
====================

$ make loongarch64_efi_defconfig
$ make

The file output/images/disk.img is a complete disk image that can be
booted, it includes the grub2 bootloader, Linux kernel and root
filesystem.

Testing under Qemu
==================

This image can also be tested using Qemu:

qemu-system-loongarch64 \
	-M virt \
	-cpu la464 \
	-nographic \
	-bios </path/to/QEMU_EFI.fd> \
	-drive file=output/images/disk.img,if=none,format=raw,id=hd0 \
	-device virtio-blk-pci,drive=hd0 \
	-netdev user,id=eth0 \
	-device virtio-net-pci,netdev=eth0

Note that </path/to/QEMU_EFI.fd> needs to point to a valid loongarch64 UEFI
firmware image for qemu.
It may be provided by your distribution as a edk2-loongarch64 package,
in path such as /usr/share/edk2/loongarch64/QEMU_EFI.fd .

[1]: https://areweloongyet.com/en/docs/old-and-new-worlds/
[2]: https://github.com/loongson/Firmware
