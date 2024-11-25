Intro
=====

The QEMU sbsa-ref machine is primarily meant for firmware development
and testing according to ARM's SBSA and SBBR standards.

Build
=====

  $ make qemu_aarch64_sbsa_defconfig
  $ make

Emulation
=========

Run the emulation with:

  qemu-system-aarch64 \
    -M sbsa-ref \
    -cpu neoverse-n1 \
    -smp 4 \
    -m 1024 \
    -nographic \
    -pflash output/images/SBSA_FLASH0.fd \
    -pflash output/images/SBSA_FLASH1.fd \
    -hda output/images/disk.img # qemu_aarch64_sbsa_defconfig

Note that if you want to run sbsa-ref emulation with QEMU provided by
your distro (i.e., not host-qemu by Buildroot) then you may need to
install the SeaBIOS package for some required drivers. On Debian:

  # apt install seabios
