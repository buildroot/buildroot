################################################################################
#
# sratom
#
################################################################################

SRATOM_VERSION = 0.6.8
SRATOM_SITE = https://download.drobilla.net
SRATOM_SOURCE = sratom-$(SRATOM_VERSION).tar.bz2
SRATOM_LICENSE = ISC
SRATOM_LICENSE_FILES = COPYING
SRATOM_DEPENDENCIES = host-pkgconf lv2 serd sord
SRATOM_INSTALL_STAGING = YES

SRATOM_CONF_OPTS += --no-coverage

ifeq ($(BR2_STATIC_LIBS),y)
SRATOM_CONF_OPTS += --static --no-shared
endif

$(eval $(waf-package))
