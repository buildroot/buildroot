################################################################################
#
# zix
#
################################################################################

ZIX_VERSION = 0.8.0
ZIX_SITE = https://download.drobilla.net
ZIX_SOURCE = zix-$(ZIX_VERSION).tar.xz
ZIX_LICENSE = ISC
ZIX_LICENSE_FILES = COPYING
ZIX_INSTALL_STAGING = YES

ZIX_CONF_OPTS += -Dbenchmarks=disabled -Ddocs=disabled -Dtests=disabled

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
ZIX_CONF_OPTS += -Dthreads=enabled
else
ZIX_CONF_OPTS += -Dthreads=disabled
endif

$(eval $(meson-package))
