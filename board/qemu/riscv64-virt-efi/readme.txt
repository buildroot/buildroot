Intro
=====

This is a RISC-V 64bit UEFI Linux boot demo in QEmu virt machine.

Build
=====

    make qemu_riscv64_virt_efi_defconfig
    make

Emulation
=========

Run the emulation with:

    qemu-system-riscv64 \
        -M virt,pflash0=pflash0,pflash1=pflash1,acpi=off \
        -smp 4 \
        -m 1024 \
        -nographic \
        -blockdev node-name=pflash0,driver=file,read-only=on,filename=output/images/RISCV_VIRT_CODE.fd \
        -blockdev node-name=pflash1,driver=file,filename=output/images/RISCV_VIRT_VARS.fd \
        \
        -drive file=output/images/disk.img,format=raw \
        \
        -netdev user,id=net0 \
        -device virtio-net-device,netdev=net0 # qemu_riscv64_virt_efi_defconfig

Note: for information, qemu version >= 8.0.0 is needed for this UEFI
Linux demo. It introduced the two pflash memories (previous versions
had only one). The host-qemu package in Buildroot (enabled in this
defconfig) is sufficient to run this demo. In case another qemu is
used (for example, from the host OS), make sure to check the version
requirement.
