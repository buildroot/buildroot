Run the emulation with:

qemu-system-ppc64 -M powernv9 -kernel output/images/vmlinux -append "console=hvc0 rootwait root=/dev/nvme0n1" -device nvme,bus=pcie.3,addr=0x0,drive=drive0,serial=1234 -drive file=output/images/rootfs.ext2,if=none,id=drive0,format=raw,cache=none -device e1000e,netdev=net0,mac=C0:FF:EE:00:01:03,bus=pcie.1,addr=0x0  -netdev user,id=net0 -serial mon:stdio -nographic # qemu_ppc64le_powernv8_defconfig

The login prompt will appear in the terminal window.
