################################################################################
#
# sord
#
################################################################################

SORD_VERSION = 0.16.12
SORD_SITE = https://download.drobilla.net
SORD_SOURCE = sord-$(SORD_VERSION).tar.xz
SORD_LICENSE = ISC
SORD_LICENSE_FILES = COPYING
SORD_DEPENDENCIES = host-pkgconf serd
SORD_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_PCRE),y)
SORD_DEPENDENCIES += pcre
endif

SORD_CONF_OPTS += -Ddocs=disabled -Dtests=disabled

$(eval $(meson-package))
