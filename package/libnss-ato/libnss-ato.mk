################################################################################
#
# libnss-ato
#
################################################################################

LIBNSS_ATO_VERSION = 0.2.0
LIBNSS_ATO_SITE = $(call github,donapieppo,libnss-ato,v$(LIBNSS_ATO_VERSION))
LIBNSS_ATO_LICENSE = LGPL-3.0+
LIBNSS_ATO_LICENSE_FILES = copyright lgpl-3.0.txt

# Skip the default build system (avoid patching Makefile for 1 .c)
define LIBNSS_ATO_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) \
		-fPIC -Wall -shared -o $(@D)/libnss_ato.so.2 \
		-Wl,-soname,libnss_ato.so.2 \
		$(@D)/libnss_ato.c
endef

define LIBNSS_ATO_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libnss_ato.so.2 $(TARGET_DIR)/lib/libnss_ato.so.2
	ln -sf libnss_ato.so.2 $(TARGET_DIR)/lib/libnss_ato.so
	$(INSTALL) -D -m 0644 $(@D)/libnss-ato.conf $(TARGET_DIR)/etc/libnss-ato.conf
endef

$(eval $(generic-package))
