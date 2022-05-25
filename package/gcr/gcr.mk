################################################################################
#
# gcr
#
################################################################################

GCR_VERSION_MAJOR = 3.40
GCR_VERSION = $(GCR_VERSION_MAJOR).0
GCR_SITE = http://ftp.acc.umu.se/pub/gnome/sources/gcr/$(GCR_VERSION_MAJOR)
GCR_SOURCE = gcr-$(GCR_VERSION).tar.xz
GCR_DEPENDENCIES = \
	host-pkgconf \
	libgcrypt \
	libglib2 \
	p11-kit \
	$(TARGET_NLS_DEPENDENCIES)
GCR_INSTALL_STAGING = YES
GCR_CONF_OPTS = -Dgtk_doc=false
# Even though COPYING is v2 the code states v2.1+
GCR_LICENSE = LGPL-2.1+
GCR_LICENSE_FILES = COPYING
GCR_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

ifeq ($(BR2_PACKAGE_GNUPG2),y)
GCR_CONF_OPTS += -Dgpg_path=/usr/bin/gpg2
else
GCR_CONF_OPTS += -Dgpg_path=/usr/bin/gpg
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
GCR_DEPENDENCIES += gobject-introspection host-libxslt host-vala
GCR_CONF_OPTS += -Dintrospection=true
else
GCR_CONF_OPTS += -Dintrospection=false
endif

ifeq ($(BR2_PACKAGE_LIBGTK3_X11),y)
GCR_DEPENDENCIES += libgtk3
GCR_CONF_OPTS += -Dgtk=true
else ifeq ($(BR2_PACKAGE_LIBGTK3_WAYLAND),y)
GCR_DEPENDENCIES += libgtk3
GCR_CONF_OPTS += -Dgtk=true
else
GCR_CONF_OPTS += -Dgtk=false
endif

$(eval $(meson-package))
