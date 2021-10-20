################################################################################
#
# ipcalc
#
################################################################################

IPCALC_VERSION = 1.0.0
IPCALC_SITE = $(call gitlab,ipcalc,ipcalc,$(IPCALC_VERSION))
IPCALC_SOURCE = ipcalc-$(IPCALC_VERSION).tar.bz2
IPCALC_LICENSE = GPL-2.0+
IPCALC_LICENSE_FILES = COPYING

IPCALC_CONF_OPTS = -Duse_geoip=disabled

ifeq ($(BR2_PACKAGE_LIBMAXMINDDB),y)
IPCALC_CONF_OPTS += -Duse_maxminddb=enabled
IPCALC_DEPENDENCIES += host-pkgconf libmaxminddb
else
IPCALC_CONF_OPTS += -Duse_maxminddb=disabled
endif

$(eval $(meson-package))
