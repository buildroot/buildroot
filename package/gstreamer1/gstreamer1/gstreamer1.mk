################################################################################
#
# gstreamer1
#
################################################################################

GSTREAMER1_VERSION = 1.22.0
GSTREAMER1_SOURCE = gstreamer-$(GSTREAMER1_VERSION).tar.xz
GSTREAMER1_SITE = https://gstreamer.freedesktop.org/src/gstreamer
GSTREAMER1_INSTALL_STAGING = YES
GSTREAMER1_LICENSE_FILES = COPYING
GSTREAMER1_LICENSE = LGPL-2.1+
GSTREAMER1_CPE_ID_VENDOR = gstreamer_project
GSTREAMER1_CPE_ID_PRODUCT = gstreamer

GSTREAMER1_CONF_OPTS = \
	-Dexamples=disabled \
	-Dtests=disabled \
	-Dbenchmarks=disabled \
	-Dtools=$(if $(BR2_PACKAGE_GSTREAMER1_INSTALL_TOOLS),enabled,disabled) \
	-Dgobject-cast-checks=disabled \
	-Dglib-asserts=disabled \
	-Dglib-checks=disabled \
	-Dextra-checks=disabled \
	-Dcheck=$(if $(BR2_PACKAGE_GSTREAMER1_CHECK),enabled,disabled) \
	-Dtracer_hooks=$(if $(BR2_PACKAGE_GSTREAMER1_TRACE),true,false) \
	-Doption-parsing=$(if $(BR2_PACKAGE_GSTREAMER1_PARSE),true,false) \
	-Dgst_debug=$(if $(BR2_PACKAGE_GSTREAMER1_GST_DEBUG),true,false) \
	-Dgst_parse=true \
	-Dregistry=$(if $(BR2_PACKAGE_GSTREAMER1_PLUGIN_REGISTRY),true,false) \
	-Ddoc=disabled

GSTREAMER1_DEPENDENCIES = \
	host-bison \
	host-flex \
	host-pkgconf \
	libglib2 \
	$(if $(BR2_PACKAGE_LIBUNWIND),libunwind) \
	$(if $(BR2_PACKAGE_VALGRIND),valgrind) \
	$(TARGET_NLS_DEPENDENCIES)

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
GSTREAMER1_CONF_OPTS += -Dintrospection=enabled
GSTREAMER1_DEPENDENCIES += gobject-introspection
else
GSTREAMER1_CONF_OPTS += -Dintrospection=disabled
endif

GSTREAMER1_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

# By default, girdir uses datadir as its prefix of which pkg-config will not
# append the sysroot directory. This results in a build failure with
# gst1-plugins-base. Changing prefix to ${libdir}/../share prevents this error.
define GSTREAMER1_FIX_GIRDIR
	$(SED) "s%girdir=.*%girdir=\$${libdir}/../share/gir-1.0%g" \
		$(STAGING_DIR)/usr/lib/pkgconfig/gstreamer-1.0.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/gstreamer-base-1.0.pc
endef
GSTREAMER1_POST_INSTALL_STAGING_HOOKS += GSTREAMER1_FIX_GIRDIR

$(eval $(meson-package))
