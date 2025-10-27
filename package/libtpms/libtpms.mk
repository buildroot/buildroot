################################################################################
#
# libtpms
#
################################################################################

LIBTPMS_VERSION = 0.10.1
LIBTPMS_SITE = $(call github,stefanberger,libtpms,v$(LIBTPMS_VERSION))
LIBTPMS_LICENSE = BSD-4-Clause
LIBTPMS_LICENSE_FILES = LICENSE
LIBTPMS_INSTALL_STAGING = YES

# Required because a plain Git clone is used:
HOST_LIBTPMS_AUTORECONF = YES
HOST_LIBTPMS_DEPENDENCIES = host-pkgconf host-openssl
HOST_LIBTPMS_CONF_OPTS = --with-openssl  -with-tpm2

$(eval $(host-autotools-package))
