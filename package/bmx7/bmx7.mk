################################################################################
#
# bmx7
#
################################################################################

BMX7_VERSION = 7.1.1
BMX7_SITE = $(call github,bmx-routing,bmx7,v$(BMX7_VERSION))
BMX7_LICENSE = GPL-2.0
BMX7_LICENSE_FILES = LICENSE
BMX7_DEPENDENCIES = zlib mbedtls wireless_tools

define BMX7_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/src
endef

define BMX7_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/src/bmx7 $(TARGET_DIR)/usr/bin/bmx7
endef

$(eval $(generic-package))
