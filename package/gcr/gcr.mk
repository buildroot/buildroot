################################################################################
#
# gcr
#
################################################################################

GCR_VERSION_MAJOR = 4.4
GCR_VERSION = $(GCR_VERSION_MAJOR).0.1
GCR_SITE = https://download.gnome.org/sources/gcr/$(GCR_VERSION_MAJOR)
GCR_SOURCE = gcr-$(GCR_VERSION).tar.xz
GCR_DEPENDENCIES = \
	host-pkgconf \
	libgcrypt \
	libglib2 \
	libsecret \
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
GCR_CONF_OPTS += -Dintrospection=true -Dvapi=true
else
GCR_CONF_OPTS += -Dintrospection=false -Dvapi=false
endif

ifeq ($(BR2_PACKAGE_LIBGTK4_X11),y)
GCR_DEPENDENCIES += libgtk4
GCR_CONF_OPTS += -Dgtk4=true
else ifeq ($(BR2_PACKAGE_LIBGTK4_WAYLAND),y)
GCR_DEPENDENCIES += libgtk4
GCR_CONF_OPTS += -Dgtk4=true
else
GCR_CONF_OPTS += -Dgtk4=false
endif

$(eval $(meson-package))
