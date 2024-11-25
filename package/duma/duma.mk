################################################################################
#
# duma
#
################################################################################

DUMA_VERSION = 2.5.21
DUMA_SITE = $(call github,johnsonjh,duma,VERSION_$(subst .,_,$(DUMA_VERSION)))
DUMA_LICENSE = GPL-2.0+, LGPL-2.1+
DUMA_LICENSE_FILES = COPYING-GPL COPYING-LGPL

DUMA_INSTALL_STAGING = YES

DUMA_OPTIONS = \
	$(if $(BR2_PACKAGE_DUMA_NO_LEAKDETECTION),-DDUMA_LIB_NO_LEAKDETECTION)

# The dependency of some source files in duma_config.h, which is generated at
# build time, is not specified in the Makefile. Force non-parallel build.
define DUMA_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) $(TARGET_CONFIGURE_OPTS) \
		OS=linux \
		DUMA_OPTIONS="$(DUMA_OPTIONS)" \
		HOST_CFLAGS="$(HOST_CFLAGS)" \
		CPPFLAGS="$(TARGET_CXXFLAGS) -std=c++11" -C $(@D)
endef

define DUMA_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		OS=linux prefix=$(STAGING_DIR)/usr install -C $(@D)
endef

define DUMA_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		OS=linux prefix=$(TARGET_DIR)/usr install -C $(@D)
endef

$(eval $(generic-package))
