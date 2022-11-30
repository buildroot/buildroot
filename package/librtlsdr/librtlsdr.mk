################################################################################
#
# librtlsdr
#
################################################################################

LIBRTLSDR_VERSION = ed0317e6a58c098874ac58b769cf2e609c18d9a5
LIBRTLSDR_SITE = $(call github,steve-m,librtlsdr,$(LIBRTLSDR_VERSION))
LIBRTLSDR_LICENSE = GPL-2.0+
LIBRTLSDR_LICENSE_FILES = COPYING
LIBRTLSDR_INSTALL_STAGING = YES
# From git
LIBRTLSDR_AUTORECONF = YES
LIBRTLSDR_DEPENDENCIES = host-pkgconf libusb
LIBRTLSDR_INSTALL_TARGET_OPTS = DESTDIR=$(TARGET_DIR) install

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
LIBRTLSDR_INSTALL_TARGET_OPTS += install-udev-rules
endif

ifeq ($(BR2_PACKAGE_LIBRTLSDR_DETACH_DRIVER),y)
LIBRTLSDR_CONF_OPTS += --enable-driver-detach
else
LIBRTLSDR_CONF_OPTS += --disable-driver-detach
endif

ifeq ($(BR2_PACKAGE_LIBRTLSDR_ZEROCOPY),y)
LIBRTLSDR_CONF_OPTS += --enable-zerocopy
else
LIBRTLSDR_CONF_OPTS += --disable-zerocopy
endif

$(eval $(autotools-package))
