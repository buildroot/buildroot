obj-m := mipi_dsi.o
mipi_dsi-objs := mipi_dsi_drv.o		\
				 touch_panel.o		\
				 panel-ili9881d.o

ccflags-y := -DDEBUG -g -std=gnu99 -Wno-declaration-after-statement

.PHONY: all clean

all:
	$(MAKE) -C '$(LINUX_DIR)' M='$(PWD)' modules

clean:
	$(MAKE) -C '$(LINUX_DIR)' M='$(PWD)' clean
