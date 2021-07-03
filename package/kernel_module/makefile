#
# Zhangqun Ming <north_sea@qq.com>
# Copyright (c) 2021 Seeed Studio
#
# MIT License
#
KVERSION ?= $(shell uname -r)

obj-m := mipi_dsi.o
mipi_dsi-objs := mipi_dsi_drv.o		\
				 touch_panel.o		\
				 panel-ili9881d.o

all:
	$(MAKE) -C /lib/modules/$(KVERSION)/build M=$(PWD) modules

install:
	$(MAKE) -C /lib/modules/$(KVERSION)/build M=$(shell pwd) modules_install

clean:
	$(MAKE) -C /lib/modules/$(KVERSION)/build M=$(PWD) clean
