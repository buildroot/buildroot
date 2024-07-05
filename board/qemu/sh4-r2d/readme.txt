Run the emulation with:

  qemu-system-sh4 -M r2d -kernel output/images/zImage -append "console=ttySC1,115200 noiotrap" -serial null -serial stdio -net nic,model=rtl8139 -net user # qemu_sh4_r2d_defconfig

The login prompt will appear in the terminal that started Qemu.
The graphical window is the framebuffer.
