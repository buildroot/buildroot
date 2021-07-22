################################################################################
#
# mudpf
#
################################################################################

# python-pymupdf's version must match mupdf's version
MUPDF_VERSION = 1.18.0
MUPDF_SOURCE = mupdf-$(MUPDF_VERSION)-source.tar.xz
MUPDF_SITE = https://mupdf.com/downloads/archive
MUPDF_LICENSE = AGPL-3.0+
MUPDF_LICENSE_FILES = COPYING
MUPDF_CPE_ID_VENDOR = artifex
MUPDF_INSTALL_STAGING = YES
MUPDF_DEPENDENCIES = \
	freetype \
	gumbo-parser \
	harfbuzz \
	host-pkgconf \
	jbig2dec jpeg \
	lcms2 openjpeg \
	xlib_libX11 \
	zlib

# 0001-Bug-703366-Fix-double-free-of-object-during-linearization.patch
MUPDF_IGNORE_CVES += CVE-2021-3407

# The pkg-config name for gumbo-parser is `gumbo`.
MUPDF_PKG_CONFIG_PACKAGES = \
	freetype2 \
	gumbo \
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

ifeq ($(BR2_PACKAGE_LIBFREEGLUT),y)
MUPDF_DEPENDENCIES += libfreeglut
else
define MUPDF_DISABLE_OPENGL
	sed -i 's/HAVE_GLUT := yes/HAVE_GLUT := no/g' $(@D)/Makerules
endef
MUPDF_POST_PATCH_HOOKS = MUPDF_DISABLE_OPENGL
endif

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
