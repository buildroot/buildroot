################################################################################
#
# libsolv
#
################################################################################

LIBSOLV_VERSION = 0.7.25
LIBSOLV_SITE = $(call github,openSUSE,libsolv,$(LIBSOLV_VERSION))
LIBSOLV_LICENSE = BSD-3-Clause
LIBSOLV_LICENSE_FILES = LICENSE.BSD
LIBSOLV_CPE_ID_VENDOR = opensuse
LIBSOLV_INSTALL_STAGING = YES
LIBSOLV_DEPENDENCIES = zlib

ifeq ($(BR2_STATIC_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
LIBSOLV_CONF_OPTS += -DENABLE_STATIC=ON
else
LIBSOLV_CONF_OPTS += -DENABLE_STATIC=OFF
endif

ifeq ($(BR2_SHARED_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
LIBSOLV_CONF_OPTS += -DDISABLE_SHARED=OFF
else
LIBSOLV_CONF_OPTS += -DDISABLE_SHARED=ON
endif

$(eval $(cmake-package))
