Intro
=====

This is a x86_64 UEFI Linux boot demo in QEMU virt machine.

Build
=====

    make qemu_x86_64_efi_defconfig
    make

Emulation
=========

Run the emulation with:

    qemu-system-x86_64 \
        -M pc \
        -m 1024 \
        -serial stdio \
        -bios output/images/OVMF.fd \
        -drive file=output/images/disk.img,format=raw \
        -netdev user,id=net0 \
        -device virtio-net-pci,netdev=net0 # qemu_x86_64_efi_defconfig

Optionally add -smp N to emulate a SMP system with N CPUs.

The login prompt will appear in the graphical window.
