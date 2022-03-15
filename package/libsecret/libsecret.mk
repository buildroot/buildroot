################################################################################
#
# libsecret
#
################################################################################

LIBSECRET_VERSION_MAJOR = 0.20
LIBSECRET_VERSION = $(LIBSECRET_VERSION_MAJOR).5
LIBSECRET_SITE = http://ftp.gnome.org/pub/GNOME/sources/libsecret/$(LIBSECRET_VERSION_MAJOR)
LIBSECRET_SOURCE = libsecret-$(LIBSECRET_VERSION).tar.xz
LIBSECRET_INSTALL_STAGING = YES
LIBSECRET_DEPENDENCIES = libglib2 $(TARGET_NLS_DEPENDENCIES)
LIBSECRET_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)
LIBSECRET_CONF_OPTS = \
	-Dgtk_doc=false \
	-Dmanpage=false \
	-Dvapi=false
LIBSECRET_LICENSE = LGPL-2.1+
LIBSECRET_LICENSE_FILES = COPYING

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
LIBSECRET_CONF_OPTS += -Dbash_completion=enabled
LIBSECRET_DEPENDENCIES += bash-completion
else
LIBSECRET_CONF_OPTS += -Dbash_completion=disabled
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBSECRET_CONF_OPTS += -Dintrospection=true
LIBSECRET_DEPENDENCIES += gobject-introspection
else
LIBSECRET_CONF_OPTS += -Dintrospection=false
endif

ifeq ($(BR2_PACKAGE_LIBGCRYPT),y)
LIBSECRET_DEPENDENCIES += libgcrypt
LIBSECRET_CONF_OPTS += -Dgcrypt=true
else
LIBSECRET_CONF_OPTS += -Dgcrypt=false
endif

ifeq ($(BR2_PACKAGE_TPM2_TSS),y)
LIBSECRET_CONF_OPTS += -Dtpm2=true
LIBSECRET_DEPENDENCIES += tpm2-tss
else
LIBSECRET_CONF_OPTS += -Dtpm2=false
endif

$(eval $(meson-package))
