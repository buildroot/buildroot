################################################################################
#
# serd
#
################################################################################

SERD_VERSION = 0.30.14
SERD_SITE = https://download.drobilla.net
SERD_SOURCE = serd-$(SERD_VERSION).tar.xz
SERD_LICENSE = ISC
SERD_LICENSE_FILES = COPYING
SERD_INSTALL_STAGING = YES

SERD_CONF_OPTS += -Ddocs=disabled -Dstatic=false -Dtests=disabled

$(eval $(meson-package))
