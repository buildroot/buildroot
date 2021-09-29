################################################################################
#
# siproxd
#
################################################################################

SIPROXD_VERSION = 0.8.3
SIPROXD_SITE = https://downloads.sourceforge.net/project/siproxd/siproxd/$(SIPROXD_VERSION)

SIPROXD_LICENSE = GPL-2.0+
SIPROXD_LICENSE_FILES = COPYING

SIPROXD_DEPENDENCIES = libosip2 libtool sqlite

SIPROXD_CONF_OPTS = --without-included-ltdl

$(eval $(autotools-package))
