################################################################################
#
# libbluray
#
################################################################################

LIBBLURAY_VERSION = 1.4.0
LIBBLURAY_SOURCE = libbluray-$(LIBBLURAY_VERSION).tar.xz
LIBBLURAY_SITE = https://download.videolan.org/pub/videolan/libbluray/$(LIBBLURAY_VERSION)
LIBBLURAY_INSTALL_STAGING = YES
LIBBLURAY_LICENSE = LGPL-2.1+
LIBBLURAY_LICENSE_FILES = COPYING
LIBBLURAY_CPE_ID_VENDOR = videolan
LIBBLURAY_DEPENDENCIES = host-pkgconf

LIBBLURAY_CONF_OPTS = -Dbdj_jar=disabled

ifeq ($(BR2_PACKAGE_LIBICONV),y)
LIBBLURAY_DEPENDENCIES += libiconv
endif

ifeq ($(BR2_PACKAGE_LIBUDFREAD),y)
LIBBLURAY_CONF_OPTS += -Dembed_udfread=false
LIBBLURAY_DEPENDENCIES += libudfread
else
LIBBLURAY_CONF_OPTS += -Dembed_udfread=true
endif

ifeq ($(BR2_PACKAGE_FREETYPE),y)
LIBBLURAY_CONF_OPTS += -Dfreetype=enabled
LIBBLURAY_DEPENDENCIES += freetype
else
LIBBLURAY_CONF_OPTS += -Dfreetype=disabled
endif

ifeq ($(BR2_PACKAGE_FONTCONFIG),y)
LIBBLURAY_CONF_OPTS += -Dfontconfig=enabled
LIBBLURAY_DEPENDENCIES += fontconfig
else
LIBBLURAY_CONF_OPTS += -Dfontconfig=disabled
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
LIBBLURAY_CONF_OPTS += -Dlibxml2=enabled
LIBBLURAY_DEPENDENCIES += libxml2
else
LIBBLURAY_CONF_OPTS += -Dlibxml2=disabled
endif

$(eval $(meson-package))
