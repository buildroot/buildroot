################################################################################
#
# libjcat
#
################################################################################

LIBJCAT_VERSION = 0.2.1
LIBJCAT_SITE = https://github.com/hughsie/libjcat/releases/download/$(LIBJCAT_VERSION)
LIBJCAT_SOURCE = libjcat-$(LIBJCAT_VERSION).tar.xz
LIBJCAT_LICENSE = LGPL-2.1+
LIBJCAT_LICENSE_FILES = LICENSE
LIBJCAT_INSTALL_STAGING = YES
LIBJCAT_DEPENDENCIES = host-pkgconf json-glib libglib2 $(TARGET_NLS_DEPENDENCIES)

LIBJCAT_LDFLAGS = $(TARGET_NLS_LIBS)

LIBJCAT_CONF_OPTS = \
	-Dgtkdoc=false \
	-Dtests=false \
	-Ded25519=false \
	-Dman=false \
	-Dcli=true

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBJCAT_DEPENDENCIES += host-vala gobject-introspection
LIBJCAT_CONF_OPTS += -Dintrospection=true -Dvapi=true
else
LIBJCAT_CONF_OPTS += -Dintrospection=false -Dvapi=false
endif

ifeq ($(BR2_PACKAGE_LIBGPG_ERROR)$(BR2_PACKAGE_LIBGPGME),yy)
LIBJCAT_DEPENDENCIES += libgpg-error libgpgme
LIBJCAT_CONF_OPTS += -Dgpg=true
else
LIBJCAT_CONF_OPTS += -Dgpg=false
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
LIBJCAT_DEPENDENCIES += gnutls
LIBJCAT_CONF_OPTS += -Dpkcs7=true
else
LIBJCAT_CONF_OPTS += -Dpkcs7=false
endif

$(eval $(meson-package))
