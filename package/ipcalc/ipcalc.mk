################################################################################
#
# ipcalc
#
################################################################################

IPCALC_VERSION = 1.0.1
IPCALC_SITE = $(call gitlab,ipcalc,ipcalc,$(IPCALC_VERSION))
IPCALC_SOURCE = ipcalc-$(IPCALC_VERSION).tar.bz2
IPCALC_LICENSE = GPL-2.0+
IPCALC_LICENSE_FILES = COPYING

ifeq ($(BR2_STATIC_LIBS),y)
IPCALC_CONF_OPTS += -Duse_runtime_linking=disabled
else
IPCALC_CONF_OPTS += -Duse_runtime_linking=enabled
endif

ifeq ($(BR2_PACKAGE_GEOIP),y)
IPCALC_CONF_OPTS += -Duse_geoip=enabled
IPCALC_DEPENDENCIES += host-pkgconf geoip
else
IPCALC_CONF_OPTS += -Duse_geoip=disabled
endif

ifeq ($(BR2_PACKAGE_LIBMAXMINDDB),y)
IPCALC_CONF_OPTS += -Duse_maxminddb=enabled
IPCALC_DEPENDENCIES += host-pkgconf libmaxminddb
else
IPCALC_CONF_OPTS += -Duse_maxminddb=disabled
endif

$(eval $(meson-package))
