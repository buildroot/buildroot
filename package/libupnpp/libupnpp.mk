################################################################################
#
# libupnpp
#
################################################################################

LIBUPNPP_VERSION = 1.0.3
LIBUPNPP_SITE = https://www.lesbonscomptes.com/upmpdcli/downloads
LIBUPNPP_LICENSE = LGPL-2.1+
LIBUPNPP_LICENSE_FILES = COPYING
LIBUPNPP_INSTALL_STAGING = YES
LIBUPNPP_DEPENDENCIES = host-pkgconf expat libcurl libnpupnp

$(eval $(meson-package))
