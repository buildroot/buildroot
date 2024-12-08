################################################################################
#
# libecoli
#
################################################################################

LIBECOLI_VERSION = 0.3.0
LIBECOLI_SITE = $(call github,rjarry,libecoli,v$(LIBECOLI_VERSION))
LIBECOLI_INSTALL_STAGING = YES
LIBECOLI_LICENSE = BSD-3-Clause
LIBECOLI_LICENSE_FILES = LICENSE

LIBECOLI_DEPENDENCIES = \
	host-pkgconf \
	libedit

LIBECOLI_CONF_OPTS = \
	-Ddoc=disabled \
	-Deditline=enabled \
	-Dexamples=disabled \
	-Dyaml=disabled \
	-Dtests=disabled

$(eval $(meson-package))
