################################################################################
#
# mudpf
#
################################################################################

# python-pymupdf's version must match mupdf's version
MUPDF_VERSION = 1.20.3
MUPDF_SOURCE = mupdf-$(MUPDF_VERSION)-source.tar.lz
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

# 0002-Bug-703366-Fix-double-free-of-object-during-linearization.patch
MUPDF_IGNORE_CVES += CVE-2021-3407

# 0003-Bug-703791-Stay-within-hash-table-max-key-size-in-cached-color-converter.patch
MUPDF_IGNORE_CVES += CVE-2021-37220

# 0005-Bug-704834-Fix-division-by-zero-for-zero-width-pages-in-muraster.patch
MUPDF_IGNORE_CVES += CVE-2021-4216

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

MUPDF_MAKE_OPTS = \
	HAVE_OBJCOPY=no \
	prefix="/usr"

ifeq ($(BR2_PACKAGE_LIBFREEGLUT),y)
MUPDF_DEPENDENCIES += libfreeglut
else
MUPDF_MAKE_OPTS += HAVE_GLUT=no
endif

define MUPDF_BUILD_CMDS
	$(MUPDF_MAKE_ENV) $(MAKE) -C $(@D) $(MUPDF_MAKE_OPTS) all
endef

define MUPDF_INSTALL_STAGING_CMDS
	$(MUPDF_MAKE_ENV) $(MAKE) -C $(@D) $(MUPDF_MAKE_OPTS) \
		DESTDIR="$(STAGING_DIR)" install-libs
endef

define MUPDF_INSTALL_TARGET_CMDS
	$(MUPDF_MAKE_ENV) $(MAKE) -C $(@D) $(MUPDF_MAKE_OPTS) \
		DESTDIR="$(TARGET_DIR)" install
endef

$(eval $(generic-package))
