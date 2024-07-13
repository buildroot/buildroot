Linux on Spike RISC-V ISA simulator
===================================

This configuration provides a minimal working setup to run a Linux
kernel in the Spike RISC-V ISA simulator.

The Spike ISA simulator can be an interresting alternative to Qemu, in
some specific cases. For example: simulating new instructions (see [1]),
simulating riscv-openocd/gdb debug sessions (see [2], [3]), or
generating an accurate per-instruction log of execution (see
riscv-isa-sim spike -l option)...

To run Buildroot Linux in Spike, use the commands:

    make spike_riscv64_defconfig
    make
    ./board/spike/riscv64/start.sh

The boot is made with the standard RISC-V OpenSBI boot loader. In
order to keep the simulation simple, the rootfs is passed as an initrd
ramfs.


[1].
https://github.com/riscv-software-src/riscv-isa-sim/tree/v1.1.0#simulating-a-new-instruction

[2].
https://github.com/riscv-software-src/riscv-isa-sim/tree/v1.1.0#debugging-with-gdb

[3].
https://github.com/riscv-collab/riscv-openocd
