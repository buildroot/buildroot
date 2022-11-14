Mender UEFI PC sample config
=====================

1. Build

  $ make mender_x86_64_efi_defconfig

  Add any additional packages required. Update the files in board/mender/x86_64
  and change /dev/vda to what is relevant for your platform: typically
  /dev/mmcblk0p for eMMC and /dev/sda for USB or SATA.

  $ make

2. Write the Pendrive

  The build process will create a Pendrive image called disk.img in
  output/images.

  Write the image to a pendrive:

  $ dd if=output/images/disk.img of=/dev/${pendrive}; sync

  Once the process is complete, insert it into the target PC and boot.

  Remember that if said PC has another boot device you might need to
  select this alternative for it to boot.

  You might need to disable Secure Boot from the setup as well.

3. Enjoy

Emulation in qemu
========================

Run the emulation with:

qemu-system-x86_64 \
    -M pc \
    -drive file=output/images/disk.img,if=virtio,format=raw \
    -net nic,model=virtio \
    -net user \
    -serial stdio \
    -bios </path/to/OVMF_CODE.fd>

Note that </path/to/OVMF.fd> needs to point to a valid x86_64 UEFI
firmware image for qemu. It may be provided by your distribution as an
edk2 or OVMF package, in a path such as /usr/share/edk2/ovmf/OVMF_CODE.fd.

Optional arguments:
 - -enable-kvm to speed up qemu. This requires a loaded kvm module on the host
    system.
 - Add -smp N to emulate an SMP system with N CPUs.

The login prompt will appear in the serial window.

Tested with QEMU 4.1.1 on Fedora 31

Creating a mender-artifact
========================

The mender artifact is created in output/images/buildroot-x86_64-1.0.mender

You may wish to change --artifact-name=1.0 to a name that best suits your
particular needs, as this option changes the mender artifact name.

Using mender
========================
Please read the mender documentation at:
https://docs.mender.io/2.2/getting-started
