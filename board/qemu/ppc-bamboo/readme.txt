Run the emulation with:

qemu-system-ppc -nographic -M bamboo -kernel vmlinux -net nic,model=virtio-net-pci -net user # qemu_ppc_bamboo_defconfig

The login prompt will appear in the terminal that started Qemu.
