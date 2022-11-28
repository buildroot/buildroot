Introduction
============

The qemu_arm_ebbr_defconfig is meant to illustrate some aspects of the Arm
EBBR specification[1] and the Arm SystemReady IR[2] compliance program.
It allows building a 32b ARMv7-A U-Boot based firmware implementing the subset
of UEFI defined by EBBR, as well as a Linux OS disk image booting with UEFI, to
run on Qemu.

Building
========

  $ make qemu_arm_ebbr_defconfig
  $ make

Generated files under output/images:

* flash.bin: A firmware image comprising TF-A, OP-TEE and the U-Boot bootloader.

* disk.img: An OS disk image comprising the GRUB bootloader, the Linux kernel
  and the root filesystem.

Running under Qemu
==================

Run the emulation with:

  qemu-system-arm \
      -M virt,secure=on \
      -bios output/images/flash.bin \
      -cpu cortex-a15 \
      -device virtio-blk-device,drive=hd0 \
      -device virtio-net-device,netdev=eth0 \
      -device virtio-rng-device,rng=rng0 \
      -drive file=output/images/disk.img,if=none,format=raw,id=hd0 \
      -m 1024 \
      -netdev user,id=eth0 \
      -no-acpi \
      -nographic \
      -object rng-random,filename=/dev/urandom,id=rng0 \
      -rtc base=utc,clock=host \
      -smp 2 # qemu_arm_ebbr_defconfig

The login prompt will appear in the terminal that started Qemu.

Using the EBBR firmware to run another OS under Qemu
----------------------------------------------------

It is possible to use the generated firmware binary to run another OS
supporting the EBBR specification.

To run another OS on emulation using a live or pre-installed image, use the same
Qemu command line as for the generated OS but adapt the OS image path in the
-drive stanza.
The 32b Arm ACS-IR image[3] is an example of a pre-installed OS image.
Linux distributions such as Debian or openSUSE provide a pre-installed OS
image.

Miscellaneous
=============

This configuration is inspired by the qemu_arm_vexpress_tz_defconfig, the
qemu_aarch64_ebbr_defconfig and the Arm SystemReady IR IoT Integration, Test,
and Certification Guide[4].

Firmware update is currently not supported.

[1]: https://github.com/ARM-software/ebbr
[2]: https://developer.arm.com/Architectures/Arm%20SystemReady%20IR
[3]: https://github.com/ARM-software/arm-systemready/tree/main/IR/prebuilt_images
[4]: https://developer.arm.com/documentation/DUI1101/1-1/?lang=en
