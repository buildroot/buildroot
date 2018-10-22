Run the emulation with:

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
