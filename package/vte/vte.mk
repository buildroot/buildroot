################################################################################
#
# vte
#
################################################################################

VTE_VERSION_MAJOR = 0.66
VTE_VERSION = $(VTE_VERSION_MAJOR).2
VTE_SOURCE = vte-$(VTE_VERSION).tar.xz
VTE_SITE = https://download.gnome.org/sources/vte/$(VTE_VERSION_MAJOR)
VTE_DEPENDENCIES = host-pkgconf libgtk3 pcre2 $(TARGET_NLS_DEPENDENCIES)
VTE_LICENSE = LGPL-3.0+
VTE_LICENSE_FILES = COPYING.LGPL3
VTE_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_ICU),y)
VTE_CONF_OPTS += -Dicu=true
VTE_DEPENDENCIES += icu
else
VTE_CONF_OPTS += -Dicu=false
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
VTE_CONF_OPTS += -Dgir=true -Dvapi=true
VTE_DEPENDENCIES += host-vala gobject-introspection
else
VTE_CONF_OPTS += -Dgir=false -Dvapi=false
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
VTE_CONF_OPTS += -Dgnutls=true
VTE_DEPENDENCIES += gnutls
else
VTE_CONF_OPTS += -Dgnutls=false
endif

ifeq ($(BR2_PACKAGE_LIBFRIBIDI),y)
VTE_CONF_OPTS += -Dfribidi=true
VTE_DEPENDENCIES += libfribidi
else
VTE_CONF_OPTS += -Dfribidi=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
VTE_CONF_OPTS += -D_systemd=true
VTE_DEPENDENCIES += systemd
else
VTE_CONF_OPTS += -D_systemd=false
endif

$(eval $(meson-package))
