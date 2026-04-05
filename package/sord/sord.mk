################################################################################
#
# sord
#
################################################################################

SORD_VERSION = 0.16.22
SORD_SITE = https://download.drobilla.net
SORD_SOURCE = sord-$(SORD_VERSION).tar.xz
SORD_LICENSE = ISC
SORD_LICENSE_FILES = COPYING
SORD_DEPENDENCIES = host-pkgconf serd zix
SORD_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_PCRE2),y)
SORD_DEPENDENCIES += pcre2
endif

SORD_CONF_OPTS += -Ddocs=disabled -Dtests=disabled

$(eval $(meson-package))
