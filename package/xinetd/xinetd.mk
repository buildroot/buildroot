################################################################################
#
# xinetd
#
################################################################################

XINETD_VERSION = 2.3.15.4
XINETD_SOURCE = xinetd-$(XINETD_VERSION).tar.xz
XINETD_SITE = https://github.com/openSUSE/xinetd/releases/download/$(XINETD_VERSION)
XINETD_LICENSE = xinetd license
XINETD_LICENSE_FILES = COPYRIGHT
XINETD_CPE_ID_VENDOR = xinetd

# From NVD's standpoint, all versions are affected by CVE-2013-4342
# since the official xinetd upstream never did a release with the
# fix. However, the openSUSE fork we're using as the fix, in:
# https://github.com/openSUSE/xinetd/commit/91e2401a219121eae15244a6b25d2e79c1af5864
XINETD_IGNORE_CVES += CVE-2013-4342

XINETD_CFLAGS = $(TARGET_CFLAGS)

# gcc-15 defaults to -std=gnu23 which introduces build failures.
# We force "-std=gnu17" for gcc version supporting it. Earlier gcc
# versions will work, since they are using the older standard.
ifeq ($(BR2_TOOLCHAIN_GCC_AT_LEAST_8),y)
XINETD_CFLAGS += -std=gnu17
endif

# Three cases here:
#  1. We have libtirpc, use it by passing special flags
#  2. We have native RPC support, use it, no need to pass special
#     flags (so this case 2 is implicit and not visible below)
#  3. We don't have RPC support, pass -DNO_RPC to disable it
ifeq ($(BR2_PACKAGE_LIBTIRPC),y)
XINETD_DEPENDENCIES += libtirpc host-pkgconf
XINETD_CFLAGS += "`$(PKG_CONFIG_HOST_BINARY) --cflags libtirpc`"
XINETD_LIBS += "`$(PKG_CONFIG_HOST_BINARY) --libs libtirpc`"
else ifeq ($(BR2_TOOLCHAIN_HAS_NATIVE_RPC),)
XINETD_CFLAGS += -DNO_RPC
endif

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
# Make ecvt(), fcvt(), and gcvt() available for SIO library
XINETD_CFLAGS += -D_GNU_SOURCE
endif

XINETD_CONF_ENV += \
	CFLAGS="$(XINETD_CFLAGS)" \
	LIBS="$(XINETD_LIBS)"

XINETD_MAKE_OPTS = AR="$(TARGET_AR)"

$(eval $(autotools-package))
