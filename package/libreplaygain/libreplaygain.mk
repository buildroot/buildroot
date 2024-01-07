################################################################################
#
# libreplaygain
#
################################################################################

LIBREPLAYGAIN_VERSION = 475
LIBREPLAYGAIN_SITE = http://files.musepack.net/source
LIBREPLAYGAIN_SOURCE = libreplaygain_r$(LIBREPLAYGAIN_VERSION).tar.gz
# upstream doesn't ship configure
LIBREPLAYGAIN_AUTORECONF = YES
LIBREPLAYGAIN_INSTALL_STAGING = YES
LIBREPLAYGAIN_LICENSE = LGPL-2.1+
LIBREPLAYGAIN_LICENSE_FILES = src/gain_analysis.c

$(eval $(autotools-package))
