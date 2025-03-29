################################################################################
#
# cairo
#
################################################################################

CAIRO_VERSION = 1.18.4
CAIRO_SOURCE = cairo-$(CAIRO_VERSION).tar.xz
CAIRO_LICENSE = LGPL-2.1 or MPL-1.1 (library)
CAIRO_LICENSE_FILES = COPYING COPYING-LGPL-2.1 COPYING-MPL-1.1
CAIRO_CPE_ID_VENDOR = cairographics
CAIRO_SITE = http://cairographics.org/releases
CAIRO_INSTALL_STAGING = YES

CAIRO_CFLAGS = $(TARGET_CFLAGS)
CAIRO_LDFLAGS = $(TARGET_LDFLAGS)

# relocation truncated to fit: R_68K_GOT16O
ifeq ($(BR2_m68k_cf),y)
CAIRO_CFLAGS += -mxgot
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),)
CAIRO_CFLAGS += -DCAIRO_NO_MUTEX=1
endif

# cairo can use C++11 atomics when available, so we need to link with
# libatomic for the architectures who need libatomic.
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
CAIRO_LDFLAGS += -latomic
endif

CAIRO_CONF_OPTS = \
	-Ddwrite=disabled \
	-Dfontconfig=enabled \
	-Dquartz=disabled \
	-Dtests=disabled \
	-Dspectre=disabled \
	-Dsymbol-lookup=disabled \
	-Dgtk_doc=false
CAIRO_DEPENDENCIES = \
	host-pkgconf \
	fontconfig \
	pixman

# Just the bare minimum to make other host-* packages happy
HOST_CAIRO_CONF_OPTS = \
	-Ddwrite=disabled \
	-Dfontconfig=enabled \
	-Dfreetype=enabled \
	-Dpng=enabled \
	-Dquartz=disabled \
	-Dtee=disabled \
	-Dxcb=disabled \
	-Dxlib=disabled \
	-Dzlib=enabled \
	-Dtests=disabled \
	-Dglib=enabled \
	-Dspectre=disabled \
	-Dsymbol-lookup=disabled \
	-Dgtk_doc=false
HOST_CAIRO_DEPENDENCIES = \
	host-freetype \
	host-fontconfig \
	host-libglib2 \
	host-libpng \
	host-pixman \
	host-pkgconf \
	host-zlib

ifeq ($(BR2_PACKAGE_LZO),y)
CAIRO_CONF_OPTS += -Dlzo=enabled
CAIRO_DEPENDENCIES += lzo
else
CAIRO_CONF_OPTS += -Dlzo=disabled
endif

ifeq ($(BR2_PACKAGE_FREETYPE),y)
CAIRO_CONF_OPTS += -Dfreetype=enabled
CAIRO_DEPENDENCIES += freetype
else
CAIRO_CONF_OPTS += -Dfreetype=disabled
endif

ifeq ($(BR2_PACKAGE_LIBGLIB2),y)
CAIRO_CONF_OPTS += -Dglib=enabled
CAIRO_DEPENDENCIES += libglib2
else
CAIRO_CONF_OPTS += -Dglib=disabled
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
CAIRO_CONF_OPTS += -Dxcb=enabled -Dxlib=enabled -Dxlib-xcb=enabled
CAIRO_DEPENDENCIES += xlib_libX11 xlib_libXext xlib_libXrender
else
CAIRO_CONF_OPTS += -Dxcb=disabled -Dxlib=disabled -Dxlib-xcb=disabled
endif

ifeq ($(BR2_PACKAGE_CAIRO_PNG),y)
CAIRO_CONF_OPTS += -Dpng=enabled
CAIRO_DEPENDENCIES += libpng
else
CAIRO_CONF_OPTS += -Dpng=disabled
endif

ifeq ($(BR2_PACKAGE_CAIRO_TEE),y)
CAIRO_CONF_OPTS += -Dtee=enabled
else
CAIRO_CONF_OPTS += -Dtee=disabled
endif

ifeq ($(BR2_PACKAGE_CAIRO_ZLIB),y)
CAIRO_CONF_OPTS += -Dzlib=enabled
CAIRO_DEPENDENCIES += zlib
else
CAIRO_CONF_OPTS += -Dzlib=disabled
endif

$(eval $(meson-package))
$(eval $(host-meson-package))
