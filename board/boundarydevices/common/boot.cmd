setenv bootargs ''

m4=''
kernelimage=zImage
bootcommand=bootz
a_base=0x10000000

#grab 1st 2/3 characters of string
setexpr cpu2 sub "^(..?).*" "\\1" "${imx_cpu}"
setexpr cpu3 sub "^(..?.?).*" "\\1" "${imx_cpu}"
if itest.s x51 == "x${cpu2}" ; then
	a_base=0x90000000
elif itest.s x53 == "x${cpu2}"; then
	a_base=0x70000000
elif itest.s x6SX == "x${cpu3}" || itest.s x6U == "x${cpu2}" || itest.s x7D == "x${cpu2}"; then
	a_base=0x80000000
elif itest.s x8M == "x${cpu2}"; then
	a_base=0x40000000
	kernelimage=Image
	bootcommand=booti
fi
if itest.s "x1" == "x${m4enabled}" ; then
	run m4boot;
	m4='-m4';
fi

setexpr a_script  ${a_base} + 0x00800000
setexpr a_zImage  ${a_base} + 0x00800000
setexpr a_fdt     ${a_base} + 0x03000000
setexpr a_initrd  ${a_base} + 0x03100000
setexpr a_reset_cause_marker ${a_base} + 0x80
setexpr a_reset_cause	     ${a_base} + 0x84

if itest.s "x" == "x${board}" ; then
	echo "!!!! Error: Your u-boot is outdated. Please upgrade.";
	exit;
fi

if itest.s "x" == "x${fdt_file}" ; then
	if itest.s x51 == "x${cpu2}" ; then
		fdt_file=imx51-${board}${m4}.dtb;
	elif itest.s x53 == "x${cpu2}" ; then
		fdt_file=imx53-${board}${m4}.dtb;
	elif itest.s x6DL == "x${cpu3}" || itest.s x6SO == "x${cpu3}" ; then
		fdt_file=imx6dl-${board}.dtb;
	elif itest.s x6QP == "x${cpu3}" ; then
		fdt_file=imx6qp-${board}.dtb;
	elif itest.s x6SX == "x${cpu3}" ; then
		fdt_file=imx6sx-${board}${m4}.dtb;
	elif itest.s x6UL == "x${cpu3}" ; then
		fdt_file=imx6ull-${board}.dtb;
	elif itest.s x7D == "x${cpu2}" ; then
		fdt_file=imx7d-${board}${m4}.dtb;
	elif itest.s x8MM == "x${cpu3}" ; then
		fdt_file=imx8mm-${board}${m4}.dtb;
	elif itest.s x8MN == "x${cpu3}" ; then
		fdt_file=imx8mn-${board}${m4}.dtb;
	elif itest.s x8MP == "x${cpu3}" ; then
		if itest *0x30360800 == 0x00824310 ; then
			fdt_file=imx8mp-a0-${board}${m4}.dtb;
		else
			fdt_file=imx8mp-${board}${m4}.dtb;
		fi
	elif itest.s x8MQ == "x${cpu3}" ; then
		fdt_file=imx8mq-${board}${m4}.dtb;
	else
		fdt_file=imx6q-${board}.dtb;
	fi
fi

if itest.s x${distro_bootpart} == x ; then
	distro_bootpart=1
fi

if load ${devtype} ${devnum}:${distro_bootpart} ${a_script} uEnv.txt ; then
    env import -t ${a_script} ${filesize}
fi

if itest.s x${console} != x ; then
	setenv bootargs ${bootargs} console=${console},115200
fi
if itest.s "x" == "x$vmalloc" ; then
	vmalloc=400M
fi
if itest.s x${consoleblank} == x ; then
	consoleblank=0
fi
setenv bootargs ${bootargs} vmalloc=${vmalloc} consoleblank=${consoleblank} rootwait fixrtc cpu=${imx_cpu} board=${board} uboot_release=${uboot_release}

if load ${devtype} ${devnum}:${distro_bootpart} ${a_fdt} ${prefix}${fdt_file} ; then
	fdt addr ${a_fdt}
else
	echo "!!!! Error loading ${prefix}${fdt_file}";
	exit;
fi

fdt resize 4096
if itest.s "x" != "x${cmd_board}" ; then
	run cmd_board
fi
if itest.s "x" != "x${cmd_custom}" ; then
	run cmd_custom
fi
if itest.s "x" != "x${cmd_hdmi}" ; then
	run cmd_hdmi
	if itest.s x != x${allow_noncea} ; then
		setenv bootargs ${bootargs} mxc_hdmi.only_cea=0;
		echo "non-CEA modes allowed on HDMI, audio may be affected";
	fi
fi
if itest.s "x" != "x${cmd_lcd}" ; then
	run cmd_lcd
fi
if itest.s "x" != "x${cmd_lcd2}" ; then
	run cmd_lcd2
fi
if itest.s "x" != "x${cmd_lvds}" ; then
	run cmd_lvds
fi
if itest.s "x" != "x${cmd_lvds2}" ; then
	run cmd_lvds2
fi
if itest.s "x" != "x${cmd_mipi}" ; then
	run cmd_mipi
fi

if test "sata" = "${devtype}" ; then
	setenv bootargs "${bootargs} root=/dev/sda${distro_bootpart}" ;
elif test "usb" = "${devtype}" ; then
	setenv bootargs "${bootargs} root=/dev/sda${distro_bootpart}" ;
else
	setenv bootargs "${bootargs} root=/dev/mmcblk${devnum}p${distro_bootpart}"
fi

if itest.s "x" != "x${disable_msi}" ; then
	setenv bootargs ${bootargs} pci=nomsi
fi;

if itest.s "x" != "x${disable_giga}" ; then
	setenv bootargs ${bootargs} fec.disable_giga=1
fi

if itest.s "x" != "x${wlmac}" ; then
	setenv bootargs ${bootargs} wlcore.mac=${wlmac}
fi

if itest.s "x" != "x${gpumem}" ; then
	setenv bootargs ${bootargs} galcore.contiguousSize=${gpumem}
fi

if itest.s "x" != "x${cma}" ; then
	setenv bootargs ${bootargs} cma=${cma}
fi

if itest.s "x" != "x${loglevel}" ; then
	setenv bootargs ${bootargs} loglevel=${loglevel}
fi

if itest.s "x" != "x${show_fdt}" ; then
	fdt print /
fi

if itest.s "x" != "x${show_env}" ; then
	printenv
fi

if load ${devtype} ${devnum}:${distro_bootpart} ${a_zImage} ${prefix}${kernelimage} ; then
	${bootcommand} ${a_zImage} - ${a_fdt}
fi
echo "Error loading kernel image"
