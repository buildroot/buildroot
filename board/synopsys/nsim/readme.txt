How to build it
===============

Configure build for the selected nSIM target. For instance, for
ARC700 nSIM target use the following defauilt configuration:
$ make snps_arc700_nsim_defconfig

Optionally modify the configuration:
$ make menuconfig

Build:
$ make

How to use it
=============

Resulting image can be booted using ARC nSIM instruction set simulator.
Free version of nSIM is available for download:
- https://www.synopsys.com/cgi-bin/dwarcnsim/req1.cgi
It provides nsimdrv binary for Linux that can be used stand-alone
or with GDB.

To run ARC700 image use the following command:
$ nsimdrv \
	-prop=nsim_mem-dev=uart0,kind=dwuart,base=0xf0000000,irq=24 \
	-prop=icache=32768,64,2,0 \
	-prop=dcache=32768,64,4,0 \
	-prop=nsim_isa_enable_timer_0=1 \
	-prop=nsim_isa_enable_timer_1=1 \
	-prop=nsim_isa_host_timer=1 \
	-prop=nsim_mmu=3 \
	-prop=nsim_isa_family=a700 \
	-prop=nsim_isa_atomic_option=1 \
	-prop=nsim_isa_dpfp=none \
	-prop=nsim_isa_shift_option=2 \
	-prop=nsim_isa_swap_option=1 \
	-prop=nsim_isa_bitscan_option=1 \
	-prop=nsim_isa_sat=1 \
	-prop=nsim_isa_mpy32=1 \
	-prop=isa_counters=1 \
	-prop=nsim_isa_pct_counters=8 \
	-prop=nsim_isa_pct_size=48 \
	output/images/vmlinux
