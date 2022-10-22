################################################################################
#
# sratom
#
################################################################################

SRATOM_VERSION = 0.6.14
SRATOM_SITE = https://download.drobilla.net
SRATOM_SOURCE = sratom-$(SRATOM_VERSION).tar.xz
SRATOM_LICENSE = ISC
SRATOM_LICENSE_FILES = COPYING
SRATOM_DEPENDENCIES = host-pkgconf lv2 serd sord
SRATOM_INSTALL_STAGING = YES

SRATOM_CONF_OPTS += -Ddocs=disabled -Dtests=disabled

$(eval $(meson-package))
