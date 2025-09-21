Introduction
============

The qemu_hppa_b160l_defconfig is meant to run Linux on a HP Visualize B160L
PA-RISC Workstation[1], emulated with Qemu.

Building
========

  $ make qemu_hppa_b160l_defconfig
  $ make

Generated files under output/images:

* rootfs.ext4: the root filesystem.
* vmlinux: the Linux kernel.

Running under Qemu
==================

Run the emulation with:

  qemu-system-hppa \
      -machine B160L \
      -append "rootwait root=/dev/sda" \
      -hda output/images/rootfs.ext4 \
      -kernel output/images/vmlinux \
      -nographic \
      -smp 2 # qemu_hppa_b160l_defconfig

The login prompt will appear in the terminal that started Qemu.

[1] https://www.openpa.net/systems/hp-visualize_b132l_b160l_b180l.html
