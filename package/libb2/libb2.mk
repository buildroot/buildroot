################################################################################
#
# libb2
#
################################################################################

LIBB2_VERSION = 0.98.1
LIBB2_SITE = $(call github,BLAKE2,libb2,v$(LIBB2_VERSION))
LIBB2_LICENSE =  CC0-1.0
LIBB2_LICENSE_FILES = COPYING
LIBB2_INSTALL_STAGING = YES
LIBB2_AUTORECONF = YES
LIBB2_DEPENDENCIES = host-pkgconf
LIBB2_CONF_OPTS = --disable-fat --disable-native
HOST_LIBB2_DEPENDENCIES = host-pkgconf
HOST_LIBB2_CONF_OPTS = --disable-fat --enable-native

$(eval $(autotools-package))
$(eval $(host-autotools-package))
