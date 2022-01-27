################################################################################
#
# serd
#
################################################################################

SERD_VERSION = 0.30.10
SERD_SITE = https://download.drobilla.net
SERD_SOURCE = serd-$(SERD_VERSION).tar.bz2
SERD_LICENSE = ISC
SERD_LICENSE_FILES = COPYING
SERD_INSTALL_STAGING = YES

SERD_CONF_OPTS += --largefile --no-coverage

ifeq ($(BR2_STATIC_LIBS),y)
SERD_CONF_OPTS += --static --no-shared --static-progs
endif

$(eval $(waf-package))
