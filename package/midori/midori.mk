################################################################################
#
# midori
#
################################################################################

MIDORI_VERSION = 9.0
MIDORI_SITE = $(call github,midori-browser,core,v$(MIDORI_VERSION))
MIDORI_LICENSE = LGPL-2.1+
MIDORI_LICENSE_FILES = COPYING
MIDORI_CPE_ID_VENDOR = midori-browser
MIDORI_DEPENDENCIES = \
	host-intltool \
	host-librsvg \
	host-pkgconf \
	host-vala \
	host-python3 \
	gcr \
	gobject-introspection \
	granite \
	json-glib \
	libarchive \
	libgtk3 \
	libpeas \
	libsoup \
	libxml2 \
	sqlite \
	webkitgtk \
	$(TARGET_NLS_DEPENDENCIES) \
	$(if $(BR2_PACKAGE_LIBICONV),libiconv)

MIDORI_CONF_OPTS += -DGIR_COMPILER_PATH=$(STAGING_DIR)/usr/bin/g-ir-compiler

$(eval $(cmake-package))
