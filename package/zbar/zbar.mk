################################################################################
#
# zbar
#
################################################################################

ZBAR_VERSION = 0.23.93
ZBAR_SOURCE = zbar-$(ZBAR_VERSION).tar.bz2
ZBAR_SITE = https://www.linuxtv.org/downloads/zbar
ZBAR_LICENSE = LGPL-2.1+
ZBAR_LICENSE_FILES = LICENSE.md
ZBAR_CPE_ID_VALID = YES
ZBAR_INSTALL_STAGING = YES
ZBAR_DEPENDENCIES = libv4l jpeg $(TARGET_NLS_DEPENDENCIES)
# uses C99 features
ZBAR_CONF_ENV = \
	CFLAGS="$(TARGET_CFLAGS) -std=gnu99" \
	LIBS=$(TARGET_NLS_LIBS)
ZBAR_CONF_OPTS = \
	--disable-doc \
	--without-imagemagick \
	--without-qt \
	--without-qt5 \
	--without-gtk \
	--without-x \
	--without-java

ifeq ($(BR2_PACKAGE_DBUS),y)
ZBAR_DEPENDENCIES += dbus
ZBAR_CONF_OPTS += --with-dbus
else
ZBAR_CONF_OPTS += --without-dbus
endif

ifeq ($(BR2_PACKAGE_PYTHON3),y)
ZBAR_DEPENDENCIES += host-python3 python3
ZBAR_CONF_OPTS += --with-python=python3
ZBAR_CONF_ENV += PYTHON_CONFIG="$(STAGING_DIR)/usr/bin/python3-config"
else
ZBAR_CONF_OPTS += --with-python=no
endif

$(eval $(autotools-package))
