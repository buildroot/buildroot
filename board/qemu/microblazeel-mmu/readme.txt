Run the emulation with:

 qemu-system-microblaze -M petalogix-s3adsp1800,endianness=little -kernel output/images/linux.bin -serial stdio # qemu_microblazeel_mmu_defconfig

The login prompt will appear in the terminal that started Qemu.
