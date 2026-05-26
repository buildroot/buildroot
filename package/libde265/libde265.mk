################################################################################
#
# libde265
#
################################################################################

LIBDE265_VERSION = 1.1.0
LIBDE265_SITE = https://github.com/strukturag/libde265/releases/download/v$(LIBDE265_VERSION)
LIBDE265_LICENSE = LGPL-3.0+
LIBDE265_LICENSE_FILES = COPYING
LIBDE265_CPE_ID_VENDOR = struktur
LIBDE265_INSTALL_STAGING = YES

# Uses __atomic_fetch_add_4
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
LIBDE265_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

ifeq ($(BR2_ARM_CPU_ARMV7M):$(BR2_ARM_CPU_HAS_NEON),y:)
LIBDE265_CONF_OPTS += -DHAVE_NEON=OFF
endif

$(eval $(cmake-package))
