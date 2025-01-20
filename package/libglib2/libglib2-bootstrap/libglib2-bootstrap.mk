################################################################################
#
# libglib2-bootstrap
#
################################################################################

# Since version 2.79.0 libglib2 needs gobject-introspection to build
# with introspection support. As gobject-introspection requires
# libglib2 to build this means a bootstrap process is needed, as
# described in the NEWS entry:
#
# 1. build libglib2 without introspection (this bootstrap package)
# 2. build build gobject-introspection
# 3. build libglib2 with introspection (the main libglib2 package).
#
# The bootstrap package is an implementation detail that nothing
# except gobject-introspection should depend on.

LIBGLIB2_BOOTSTRAP_VERSION_MAJOR = $(LIBGLIB2_VERSION_MAJOR)
LIBGLIB2_BOOTSTRAP_VERSION = $(LIBGLIB2_VERSION)
LIBGLIB2_BOOTSTRAP_SOURCE = $(LIBGLIB2_SOURCE)
LIBGLIB2_BOOTSTRAP_SITE = $(LIBGLIB2_SITE)
LIBGLIB2_BOOTSTRAP_LICENSE = $(LIBGLIB2_LICENSE)
LIBGLIB2_BOOTSTRAP_LICENSE_FILES = $(LIBGLIB2_LICENSE_FILES)
LIBGLIB2_BOOTSTRAP_CPE_ID_VENDOR = $(LIBGLIB2_CPE_ID_VENDOR)
LIBGLIB2_BOOTSTRAP_CPE_ID_PRODUCT = $(LIBGLIB2_CPE_ID_PRODUCT)
LIBGLIB2_BOOTSTRAP_INSTALL_STAGING = YES
LIBGLIB2_BOOTSTRAP_DL_SUBDIR = libglib2

LIBGLIB2_BOOTSTRAP_CFLAGS = $(LIBGLIB2_CFLAGS)
LIBGLIB2_BOOTSTRAP_LDFLAGS = $(LIBGLIB2_LDFLAGS)

LIBGLIB2_BOOTSTRAP_DEPENDENCIES = \
	libffi \
	pcre2 \
	zlib \
	$(TARGET_NLS_DEPENDENCIES)

LIBGLIB2_BOOTSTRAP_CONF_OPTS = \
	-Dglib_debug=disabled \
	-Dlibelf=disabled \
	-Dgio_module_dir=/usr/lib/gio/modules \
	-Dtests=false \
	-Doss_fuzz=disabled \
	-Dintrospection=disabled \
	-Dselinux=disabled \
	-Dxattr=false \
	-Dlibmount=disabled

LIBGLIB2_BOOTSTRAP_MESON_EXTRA_PROPERTIES = \
	have_c99_vsnprintf=true \
	have_c99_snprintf=true \
	have_unix98_printf=true

LIBGLIB2_BOOTSTRAP_POST_INSTALL_TARGET_HOOKS = $(LIBGLIB2_POST_INSTALL_TARGET_HOOKS)

HOST_LIBGLIB2_BOOTSTRAP_DEPENDENCIES = \
	host-gettext \
	host-libffi \
	host-pcre2 \
	host-pkgconf \
	host-util-linux \
	host-zlib

HOST_LIBGLIB2_BOOTSTRAP_CONF_OPTS = \
	-Ddtrace=false \
	-Dglib_debug=disabled \
	-Dintrospection=disabled \
	-Dlibelf=disabled \
	-Dselinux=disabled \
	-Dsystemtap=false \
	-Dxattr=false \
	-Dtests=false \
	-Doss_fuzz=disabled

$(eval $(meson-package))
$(eval $(host-meson-package))
