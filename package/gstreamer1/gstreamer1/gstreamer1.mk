################################################################################
#
# gstreamer1
#
################################################################################

GSTREAMER1_VERSION = 1.16.2
GSTREAMER1_SOURCE = gstreamer-$(GSTREAMER1_VERSION).tar.xz
GSTREAMER1_SITE = https://gstreamer.freedesktop.org/src/gstreamer
GSTREAMER1_INSTALL_STAGING = YES
GSTREAMER1_LICENSE_FILES = COPYING
GSTREAMER1_LICENSE = LGPL-2.0+, LGPL-2.1+

ifeq ($(BR2_PACKAGE_GSTREAMER1_GIT),y)
GSTREAMER1_SOURCE = gstreamer-$(GSTREAMER1_VERSION).tar.bz2
GSTREAMER1_SITE = "https://gitlab.freedesktop.org/gstreamer/gstreamer/-/archive/$(GSTREAMER1_VERSION)/"
BR_NO_CHECK_HASH_FOR += $(GSTREAMER1_SOURCE)
GSTREAMER1_AUTORECONF = YES
GSTREAMER1_AUTORECONF_OPTS = -I $(@D)/common/m4
GSTREAMER1_GETTEXTIZE = YES
GSTREAMER1_POST_EXTRACT_HOOKS += GSTREAMER1_COMMON_EXTRACT
GSTREAMER1_PRE_CONFIGURE_HOOKS += GSTREAMER1_FIX_AUTOPOINT
GSTREAMER1_POST_INSTALL_TARGET_HOOKS += GSTREAMER1_REMOVE_LA_FILES
endif

GSTREAMER1_EXTRA_COMPILER_OPTIONS =
ifeq ($(BR2_PACKAGE_GSTREAMER1_SYMBOLS),y)
GSTREAMER1_EXTRA_COMPILER_OPTIONS += -g
ifeq ($(BR2_PACKAGE_GSTREAMER1_NO_OPTIMIZATIONS),y)
GSTREAMER1_EXTRA_COMPILER_OPTIONS += -O0
endif
endif

GSTREAMER1_CONF_OPTS = \
	-Dexamples=disabled \
	-Dtests=disabled \
	-Dbenchmarks=disabled \
	-Dgtk_doc=disabled \
	-Dintrospection=disabled \
	-Dglib-asserts=disabled \
	-Dglib-checks=disabled \
	-Dgobject-cast-checks=disabled \
	-Dcheck=$(if $(BR2_PACKAGE_GSTREAMER1_CHECK),enabled,disabled) \
	-Dtracer_hooks=$(if $(BR2_PACKAGE_GSTREAMER1_TRACE),true,false) \
	-Doption-parsing=$(if $(BR2_PACKAGE_GSTREAMER1_PARSE),true,false) \
	-Dgst_debug=$(if $(BR2_PACKAGE_GSTREAMER1_GST_DEBUG),true,false) \
	-Dregistry=$(if $(BR2_PACKAGE_GSTREAMER1_PLUGIN_REGISTRY),true,false) \
	-Dtools=$(if $(BR2_PACKAGE_GSTREAMER1_INSTALL_TOOLS),enabled,disabled)

GSTREAMER1_DEPENDENCIES = \
	host-bison \
	host-flex \
	host-pkgconf \
	libglib2 \
	$(if $(BR2_PACKAGE_LIBUNWIND),libunwind) \
	$(if $(BR2_PACKAGE_VALGRIND),valgrind) \
	$(TARGET_NLS_DEPENDENCIES)

GSTREAMER1_CFLAGS = $(TARGET_CFLAGS) $(GSTREAMER1_EXTRA_COMPILER_OPTIONS)
GSTREAMER1_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

$(eval $(meson-package))
