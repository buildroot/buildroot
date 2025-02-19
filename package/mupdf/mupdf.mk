################################################################################
#
# mudpf
#
################################################################################

# python-pymupdf's version be compatible with mupdf's version
MUPDF_VERSION = 1.23.9
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
	zlib

# libfreeglut/0001-Plug-memory-leak-that-happens-upon-error.patch
# Fix is in libfreeglut, but CVE applied to mupdf.
MUPDF_IGNORE_CVES = \
	CVE-2024-24258 \
	CVE-2024-24259

# mupdf doesn't use CFLAGS and LIBS but XCFLAGS and XLIBS instead.
# with USE_SYSTEM_LIBS it will try to use system libraries instead of the bundled ones.
MUPDF_MAKE_ENV = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) \
	XCFLAGS="$(TARGET_CFLAGS)" \
	XLIBS="$(TARGET_LDFLAGS)" \
	USE_SYSTEM_LIBS=yes

MUPDF_MAKE_OPTS = \
	HAVE_OBJCOPY=no \
	prefix="/usr"

ifeq ($(BR2_STATIC_LIBS),y)
MUPDF_MAKE_OPTS += shared=no
else
MUPDF_MAKE_OPTS += shared=yes
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBX11)$(BR2_PACKAGE_XLIB_LIBXEXT),yy)
MUPDF_MAKE_OPTS += HAVE_X11=yes
MUPDF_DEPENDENCIES += xlib_libX11 xlib_libXext
else
MUPDF_MAKE_OPTS += HAVE_X11=no
endif

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
