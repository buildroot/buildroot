################################################################################
#
# reproc
#
################################################################################

REPROC_VERSION = 14.2.4
REPROC_SITE = $(call github,DaanDeMeyer,reproc,v$(REPROC_VERSION))
REPROC_LICENSE = MIT
REPROC_LICENSE_FILES = LICENSE
REPROC_INSTALL_STAGING = YES

ifeq ($(BR2_INSTALL_LIBSTDCPP)$(BR2_TOOLCHAIN_GCC_AT_LEAST_4_8),yy) # C++11
REPROC_CONF_OPTS += -DREPROC++=ON
endif

$(eval $(cmake-package))
