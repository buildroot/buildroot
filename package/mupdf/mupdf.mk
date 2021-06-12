################################################################################
#
# mudpf
#
################################################################################

# python-pymupdf's version must match exactly mupdf's version
MUPDF_VERSION = 1.16.0
MUPDF_SOURCE = mupdf-$(MUPDF_VERSION)-source.tar.gz
MUPDF_SITE = https://mupdf.com/downloads/archive
MUPDF_LICENSE = AGPL-3.0+
MUPDF_LICENSE_FILES = COPYING
MUPDF_CPE_ID_VENDOR = artifex
MUPDF_INSTALL_STAGING = YES
MUPDF_DEPENDENCIES = \
	freetype \
	harfbuzz \
	host-pkgconf \
	jbig2dec jpeg \
	lcms2 openjpeg \
	xlib_libX11 \
	zlib

MUPDF_PKG_CONFIG_PACKAGES = \
	freetype2 \
	harfbuzz \
	libjpeg \
	zlib

MUPDF_CFLAGS = \
	$(TARGET_CFLAGS) \
	`$(PKG_CONFIG_HOST_BINARY) --cflags $(MUPDF_PKG_CONFIG_PACKAGES)` \
	-fPIC # -fPIC is needed because the Makefile doesn't append it.

MUPDF_LDFLAGS = \
	$(TARGET_LDFLAGS) \
	`$(PKG_CONFIG_HOST_BINARY) --libs $(MUPDF_PKG_CONFIG_PACKAGES)`

# mupdf doesn't use CFLAGS and LIBS but XCFLAGS and XLIBS instead.
# with USE_SYSTEM_LIBS it will try to use system libraries instead of the bundled ones.
MUPDF_MAKE_ENV = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) \
	XCFLAGS="$(MUPDF_CFLAGS)" \
	XLIBS="$(MUPDF_LDFLAGS)" \
	USE_SYSTEM_LIBS=yes

# Modern versions of mupdf depend on OpenGL,
# we disable it because it may not be available:
define MUPDF_DISABLE_OPENGL
	sed -i 's/HAVE_GLUT := yes/HAVE_GLUT := no/g' $(@D)/Makerules
endef

MUPDF_POST_PATCH_HOOKS = MUPDF_DISABLE_OPENGL

define MUPDF_BUILD_CMDS
	$(MUPDF_MAKE_ENV) $(MAKE) -C $(@D) all
endef

define MUPDF_INSTALL_STAGING_CMDS
	$(MUPDF_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR="$(STAGING_DIR)" prefix="/usr" install_libs
endef

define MUPDF_INSTALL_TARGET_CMDS
	$(MUPDF_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR="$(TARGET_DIR)" prefix="/usr" install
endef

$(eval $(generic-package))
