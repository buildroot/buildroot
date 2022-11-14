Canaan KD233 Board
==================

The Canaan KD233 is a dual-core RISC-V 64-bits board based on the Canaan
Kendryte K210 SoC.

Prerequisite
------------

In order to use the kflash utility to program this board, the user must have
access to the board USB serial device file. The simplest way to do this is to
add your user to the same group as this device file. Assume the device file is
/dev/ttyUSB0, first identify the device group name. In most cases, it is
either "dialout" or "uucp". Also verify that read-write access is enabled for
the group:

```
$ ls -l /dev/ttyUSB0
crw-rw---- 1 root dialout 188, 0 May 26 13:48 /dev/ttyUSB0
```

Then add yourself to that group (dialout in this example):

```
$ sudo usermod -a -G dialout $(whoami)
```

To enable the above, it is sometimes necessary to logout and login again.

Buildroot Configuration
-----------------------

Unlike other K210 based boards (Sipeed boards), U-Boot does not work on the
KD233 board due to the different wiring for the SD-Card mmc controller. As such,
the KD233 board can only be used by directly booting into Linux Kernel.

buildroot can be configured to do so using the canaan_kd233_defconfig
configuration file. This configuration allows building a bootable kernel image
with a built-in initramfs root file system (the board SD card is not used). The
built kernel image can be flashed directly to the board ROM for direct booting.
No boot loader is required.

Once booted, the on-board SD card can be used by Linux.

The configuration file will also compile and install the kflash and
pyserial-miniterm host utilities to program bootable image files to the board
and open a serial terminal console.

Direct Linux Kernel Boot
-------------------------

Using the canaan_kd233_defconfig configuration, the bootable kernel binary image
is built as follows.

```
$ make canaan_kd233_defconfig
$ make
```

The bootable binary image is the output/images/loader.bin file. This image file
can be written to the board boot flash using the kflash utility.

```
$ output/host/bin/kflash -b 1500000 -p /dev/ttyUSB0 -t output/images/loader.bin
```

Once the kernel image file is fully programmed, a terminal console is open and
the board can be rebooted by pressing the reset button on the board (if it does
not reboot automatically).

The output will be similar to the following.

```
[    0.000000] Linux version 5.17.0 (foo@bar.com) (riscv64-buildroot-linux-uclibc-gcc.br_real (Buildroot 2022.02-560-g6a2b542a09-dirty) 10.3.0, GNU ld (GNU Binutils) 2.32) #2 SMP Thu Apr 21 16:40:44 JST 2022
[    0.000000] Machine model: Kendryte KD233
[    0.000000] earlycon: sifive0 at MMIO 0x0000000038000000 (options '115200n8')
[    0.000000] printk: bootconsole [sifive0] enabled
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000807fffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000807fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000807fffff]
[    0.000000] riscv: ISA extensions acdfim
[    0.000000] riscv: ELF capabilities acdfim
[    0.000000] percpu: max_distance=0x16000 too large for vmalloc space 0x0
[    0.000000] percpu: Embedded 11 pages/cpu s15264 r0 d29792 u45056
[    0.000000] percpu: wasting 10 pages per chunk
[    0.000000] Built 1 zonelists, mobility grouping off.  Total pages: 2020
[    0.000000] Kernel command line: earlycon console=ttySIF0
[    0.000000] Dentry cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.000000] Inode-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 5984K/8192K available (964K kernel code, 137K rwdata, 205K rodata, 546K init, 66K bss, 2208K reserved, 0K cma-reserved)
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 64 local interrupts mapped
[    0.000000] plic: interrupt-controller@c000000: mapped 65 interrupts with 2 handlers for 4 contexts.
[    0.000000] k210-clk: clock-controller: CPU running at 390 MHz
[    0.000000] clint: timer@2000000: timer running at 7800000 Hz
[    0.000000] clocksource: clint_clocksource: mask: 0xffffffffffffffff max_cycles: 0x3990be68b, max_idle_ns: 881590404272 ns
[    0.000001] sched_clock: 64 bits at 7MHz, resolution 128ns, wraps every 4398046511054ns
[    0.008178] Calibrating delay loop (skipped), value calculated using timer frequency.. 15.60 BogoMIPS (lpj=31200)
[    0.018251] pid_max: default: 4096 minimum: 301
[    0.022861] Mount-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.029971] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.040234] rcu: Hierarchical SRCU implementation.
[    0.045110] smp: Bringing up secondary CPUs ...
[    0.050211] smp: Brought up 1 node, 2 CPUs
[    0.054340] devtmpfs: initialized
[    0.070401] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.079473] pinctrl core: initialized pinctrl subsystem
[    0.117795] clocksource: Switched to clocksource clint_clocksource
[    0.130245] workingset: timestamp_bits=62 max_order=11 bucket_order=0
[    0.176925] k210-sysctl 50440000.syscon: K210 system controller
[    0.192947] k210-rst 50440000.syscon:reset-controller: K210 reset controller
[    0.200870] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.210947] i2c_dev: i2c /dev entries driver
[    0.220535] k210-fpioa 502b0000.pinmux: K210 FPIOA pin controller
[    0.232253] 38000000.serial: ttySIF0 at MMIO 0x38000000 (irq = 1, base_baud = 115200) is a SiFive UART v0
[    0.241202] printk: console [ttySIF0] enabled
[    0.241202] printk: console [ttySIF0] enabled
[    0.249818] printk: bootconsole [sifive0] disabled
[    0.249818] printk: bootconsole [sifive0] disabled
[    0.261664] panel@0 enforce active low on chipselect handle
[    0.275950] Freeing unused kernel image (initmem) memory: 540K
[    0.281098] This architecture does not have kernel memory protection.
[    0.287520] Run /init as init process
          __  _
         / / (_) ____   _   _ __  __
        / /  | ||  _ \ | | | |\ \/ /
       / /___| || | | || |_| | >  <
      /_____/|_||_| |_| \____|/_/\_\
    64-bits RISC-V Kendryte K210 NOMMU

/ #
```

To open a terminal console without re-flashing the board, the pyserial-miniterm
host tool can be used.

```
$ output/host/bin/pyserial-miniterm --raw --eol=LF /dev/ttyUSB0 115200
```

The options "--raw" and "--eol=LF" are added here to avoid a double carriage
return each time a command is entered.
