obj-m += mipi_dsi.o
mipi_dsi-objs := ./mipi_dsi/mipi_dsi_drv.o		\
		./mipi_dsi/touch_panel.o		\
		./mipi_dsi/panel-ili9881d.o

obj-m += lis331dlh-i2c.o
lis331dlh-i2c-objs := ./lis3lv02d/lis3lv02d.o \
			./lis3lv02d/lis3lv02d_i2c.o

obj-m += als_ltr30x.o
als_ltr30x-objs := ./ltr30x/ltr30x.o

ccflags-y := -DDEBUG -g -std=gnu99 -Wno-declaration-after-statement

.PHONY: all clean

all:
	$(MAKE) -C '$(LINUX_DIR)' M='$(PWD)' modules

clean:
	$(MAKE) -C '$(LINUX_DIR)' M='$(PWD)' clean
