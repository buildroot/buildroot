################################################################################
#
# sbc
#
################################################################################

SBC_VERSION = 2.1
SBC_SOURCE = sbc-$(SBC_VERSION).tar.xz
SBC_SITE = $(BR2_KERNEL_MIRROR)/linux/bluetooth
SBC_INSTALL_STAGING = YES
SBC_DEPENDENCIES = host-pkgconf
SBC_LICENSE := LGPL-2.1+ (library)
SBC_LICENSE_FILES = COPYING COPYING.LIB

# gcc-15 defaults to -std=gnu23 which introduces build failures.
# We force "-std=gnu17" for gcc version supporting it. Earlier gcc
# versions will work, since they are using the older standard.
ifeq ($(BR2_TOOLCHAIN_GCC_AT_LEAST_8),y)
SBC_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -std=gnu17"
endif

ifeq ($(BR2_PACKAGE_SBC_TOOLS),y)
SBC_DEPENDENCIES += libsndfile
SBC_CONF_OPTS += --enable-tools --enable-tester
SBC_LICENSE += , GPL-2.0+ (programs)
else
SBC_CONF_OPTS += --disable-tools --disable-tester
endif

$(eval $(autotools-package))
