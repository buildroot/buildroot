################################################################################
#
# libdeflate
#
################################################################################

LIBDEFLATE_VERSION = 1.18
LIBDEFLATE_SITE = $(call github,ebiggers,libdeflate,v$(LIBDEFLATE_VERSION))
LIBDEFLATE_LICENSE = MIT
LIBDEFLATE_LICENSE_FILES = COPYING
LIBDEFLATE_INSTALL_STAGING = YES

LIBDEFLATE_CFLAGS = -D_DEFAULT_SOURCE

# Thumb build is broken, build in ARM mode, since all architectures
# that support Thumb1 also support ARM.
ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
LIBDEFLATE_CFLAGS += -marm
endif

LIBDEFLATE_CONF_OPTS = \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(LIBDEFLATE_CFLAGS)"

ifeq ($(BR2_SHARED_LIBS),y)
LIBDEFLATE_CONF_OPTS += \
	-DLIBDEFLATE_BUILD_SHARED_LIB=ON \
	-DLIBDEFLATE_BUILD_STATIC_LIB=OFF
else ifeq ($(BR2_STATIC_LIBS),y)
LIBDEFLATE_CONF_OPTS += \
	-DLIBDEFLATE_BUILD_SHARED_LIB=OFF \
	-DLIBDEFLATE_BUILD_STATIC_LIB=ON
else ifeq ($(BR2_SHARED_STATIC_LIBS),y)
LIBDEFLATE_CONF_OPTS += \
	-DLIBDEFLATE_BUILD_SHARED_LIB=ON \
	-DLIBDEFLATE_BUILD_STATIC_LIB=ON
endif

$(eval $(cmake-package))
