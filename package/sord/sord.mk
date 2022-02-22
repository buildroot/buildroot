################################################################################
#
# sord
#
################################################################################

SORD_VERSION = 0.16.8
SORD_SITE = https://download.drobilla.net
SORD_SOURCE = sord-$(SORD_VERSION).tar.bz2
SORD_LICENSE = ISC
SORD_LICENSE_FILES = COPYING
SORD_DEPENDENCIES = host-pkgconf serd
SORD_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_PCRE),y)
SORD_DEPENDENCIES += pcre
endif

SORD_CONF_OPTS += --no-coverage

ifeq ($(BR2_STATIC_LIBS),y)
SORD_CONF_OPTS += --static --no-shared --static-progs
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),)
SORD_CONF_OPTS += --no-threads
endif

$(eval $(waf-package))
