Intro
=====

This is a LoongArch 64bit UEFI Linux boot demo in QEMU virt machine.

Build
=====

    make qemu_loongarch64_virt-efi_defconfig
    make

Emulation
=========

Run the emulation with:

    qemu-system-loongarch64 \
        -M virt \
        -smp 2 \
        -m 1024 \
        -nographic \
        -bios output/images/QEMU_EFI.fd \
        -drive file=output/images/disk.img,format=raw \
        -netdev user,id=net0 \
        -device virtio-net-pci,netdev=net0 # qemu_loongarch64_virt_efi_defconfig

Note: for information, qemu version >= 9.0.0 is needed for this UEFI
Linux demo. The host-qemu package in Buildroot (enabled in this
defconfig) is sufficient to run this demo. In case another qemu is
used (for example, from the host OS), make sure to check the version
requirement.
