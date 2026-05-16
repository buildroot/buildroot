################################################################################
#
# fwts
#
################################################################################

FWTS_VERSION = 26.03.00
FWTS_SOURCE = fwts-V$(FWTS_VERSION).tar.gz
FWTS_SITE = https://github.com/fwts/fwts/releases/download/V$(FWTS_VERSION)
FWTS_LICENSE = GPL-2.0, LGPL-2.1, Custom
FWTS_LICENSE_FILES = debian/copyright
# 0001-build-allow-disabling-Werror.patch
FWTS_AUTORECONF = YES
FWTS_CONF_OPTS = --disable-werror
FWTS_DEPENDENCIES = host-bison host-flex host-pkgconf libglib2 libbsd \
	$(if $(BR2_PACKAGE_BASH_COMPLETION),bash-completion) \
	$(if $(BR2_PACKAGE_DTC),dtc)

ifeq ($(BR2_OPTIMIZE_0),y)
FWTS_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -O1"
endif

$(eval $(autotools-package))
