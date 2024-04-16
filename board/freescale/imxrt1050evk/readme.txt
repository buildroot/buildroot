NXP i.MXRT1050 EVK board
------------------------

i.MX RT1050 are NXP's crossover MCUs. They combine the high performance and high
level of integration of an applications processors with the ease-of-use and
real-time functionality of a microcontroller. The i.MX RT1050 MCU runs on the Arm
Cortex-M7 core at 600 MHz.
https://www.nxp.com/design/development-boards/i-mx-evaluation-and-development-boards/i-mx-rt1050-evaluation-kit:MIMXRT1050-EVK

To build a minimal support for this board:

$ make imxrt1050-evk_defconfig
$ make

Buildroot prepares a bootable "sdcard.img" image in the output/images/
directory, ready to be flashed into the SD card:

$ dd if=output/images/sdcard.img of=/dev/sdX
Where 'sdX' is the device node of the uSD.

Jumper settings:

   SW7: 1 0 1 0

Where 0 means bottom position and 1 means top position (from the
switch label numbers reference).

Connect the USB cable between the EVK and the PC for the console.

Insert the micro SD card in the board, power it up and U-Boot messages should come up.
