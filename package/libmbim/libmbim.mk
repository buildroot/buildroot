################################################################################
#
# libmbim
#
################################################################################

LIBMBIM_VERSION = 1.28.2
LIBMBIM_SITE = https://gitlab.freedesktop.org/mobile-broadband/libmbim/-/archive/$(LIBMBIM_VERSION)
LIBMBIM_LICENSE = LGPL-2.1+ (library), GPL-2.0+ (programs)
LIBMBIM_LICENSE_FILES = COPYING COPYING.LIB
LIBMBIM_CPE_ID_VENDOR = freedesktop
LIBMBIM_INSTALL_STAGING = YES

LIBMBIM_DEPENDENCIES = libglib2
LIBMBIM_CONF_OPTS = -Dman=false

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBMBIM_DEPENDENCIES += gobject-introspection
LIBMBIM_CONF_OPTS += -Dintrospection=true
else
LIBMBIM_CONF_OPTS += -Dintrospection=false
endif

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
LIBMBIM_DEPENDENCIES += bash-completion
LIBMBIM_CONF_OPTS += -Dbash_completion=true
else
LIBMBIM_CONF_OPTS += -Dbash_completion=false
endif

$(eval $(meson-package))
