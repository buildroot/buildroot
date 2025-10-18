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

# 0001-Fix-compilation-on-gcc-14.patch
SIPROXD_AUTORECONF = YES
SIPROXD_CONF_OPTS = --without-included-ltdl

$(eval $(autotools-package))
