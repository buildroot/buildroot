################################################################################
#
# libvips
#
################################################################################

LIBVIPS_VERSION = 8.17.2
LIBVIPS_SOURCE = vips-$(LIBVIPS_VERSION).tar.xz
LIBVIPS_SITE = https://github.com/libvips/libvips/releases/download/v$(LIBVIPS_VERSION)
LIBVIPS_LICENSE = LGPL-2.1+
LIBVIPS_LICENSE_FILES = LICENSE
LIBVIPS_CPE_ID_VENDOR = libvips

# Sparc64 compile fails, for all optimization levels except -O0. To
# fix the problem, use -O0 with no optimization instead. Bug reported
# upstream at https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69038.
ifeq ($(BR2_sparc64),y)
LIBVIPS_CXXFLAGS += -O0
endif

LIBVIPS_CONF_ENV += CXXFLAGS="$(TARGET_CXXFLAGS) $(LIBVIPS_CXXFLAGS)" \
	LIBS=$(TARGET_NLS_LIBS)

LIBVIPS_CONF_OPTS = \
	-Dopenexr=disabled \
	-Dopenslide=disabled \
	-Dcfitsio=disabled \
	-Dpangocairo=disabled
LIBVIPS_INSTALL_STAGING = YES
LIBVIPS_DEPENDENCIES = \
	host-pkgconf expat libglib2 \
	$(TARGET_NLS_DEPENDENCIES)

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBVIPS_CONF_OPTS += -Dintrospection=enabled
LIBVIPS_DEPENDENCIES += gobject-introspection
else
LIBVIPS_CONF_OPTS += -Dintrospection=disabled
endif

ifeq ($(BR2_PACKAGE_IMAGEMAGICK),y)
LIBVIPS_CONF_OPTS += \
	-Dmagick=enabled \
	-Dmagick-package=MagickCore
LIBVIPS_DEPENDENCIES += imagemagick
else ifeq ($(BR2_PACKAGE_GRAPHICSMAGICK),y)
LIBVIPS_CONF_OPTS += \
	-Dmagick=enabled \
	-Dmagick-package=GraphicsMagick
LIBVIPS_DEPENDENCIES += graphicsmagick
else
LIBVIPS_CONF_OPTS += -Dmagick=disabled
endif

ifeq ($(BR2_PACKAGE_JPEG),y)
LIBVIPS_CONF_OPTS += -Djpeg=enabled
LIBVIPS_DEPENDENCIES += jpeg
else
LIBVIPS_CONF_OPTS += -Djpeg=disabled
endif

ifeq ($(BR2_PACKAGE_LCMS2),y)
LIBVIPS_CONF_OPTS += -Dlcms=enabled
LIBVIPS_DEPENDENCIES += lcms2
else
LIBVIPS_CONF_OPTS += -Dlcms=disabled
endif

ifeq ($(BR2_PACKAGE_LIBPNG),y)
LIBVIPS_CONF_OPTS += -Dpng=enabled
LIBVIPS_DEPENDENCIES += libpng
else
LIBVIPS_CONF_OPTS += -Dpng=disabled
endif

ifeq ($(BR2_PACKAGE_LIBRSVG),y)
LIBVIPS_CONF_OPTS += -Drsvg=enabled
LIBVIPS_DEPENDENCIES += librsvg
else
LIBVIPS_CONF_OPTS += -Drsvg=disabled
endif

ifeq ($(BR2_PACKAGE_MATIO),y)
LIBVIPS_CONF_OPTS += -Dmatio=enabled
LIBVIPS_DEPENDENCIES += matio
else
LIBVIPS_CONF_OPTS += -Dmatio=disabled
endif

ifeq ($(BR2_PACKAGE_ORC),y)
LIBVIPS_CONF_OPTS += -Dorc=enabled
LIBVIPS_DEPENDENCIES += orc
else
LIBVIPS_CONF_OPTS += -Dorc=disabled
endif

ifeq ($(BR2_PACKAGE_POPPLER),y)
LIBVIPS_CONF_OPTS += -Dpoppler=enabled
LIBVIPS_DEPENDENCIES += poppler
else
LIBVIPS_CONF_OPTS += -Dpoppler=disabled
endif

ifeq ($(BR2_PACKAGE_TIFF),y)
LIBVIPS_CONF_OPTS += -Dtiff=enabled
LIBVIPS_DEPENDENCIES += tiff
else
LIBVIPS_CONF_OPTS += -Dtiff=disabled
endif

ifeq ($(BR2_PACKAGE_FFTW_DOUBLE),y)
LIBVIPS_CONF_OPTS += -Dfftw=enabled
LIBVIPS_DEPENDENCIES += fftw-double
else
LIBVIPS_CONF_OPTS += -Dfftw=disabled
endif

ifeq ($(BR2_PACKAGE_LIBEXIF),y)
LIBVIPS_CONF_OPTS += -Dexif=enabled
LIBVIPS_DEPENDENCIES += libexif
else
LIBVIPS_CONF_OPTS += -Dexif=disabled
endif

ifeq ($(BR2_PACKAGE_LIBHEIF),y)
LIBVIPS_CONF_OPTS += -Dheif=enabled
LIBVIPS_DEPENDENCIES += libheif
else
LIBVIPS_CONF_OPTS += -Dheif=disabled
endif

ifeq ($(BR2_PACKAGE_WEBP_DEMUX)$(BR2_PACKAGE_WEBP_MUX),yy)
LIBVIPS_CONF_OPTS += -Dwebp=enabled
LIBVIPS_DEPENDENCIES += webp
else
LIBVIPS_CONF_OPTS += -Dwebp=disabled
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
LIBVIPS_CONF_OPTS += -Dzlib=enabled
LIBVIPS_DEPENDENCIES += zlib
else
LIBVIPS_CONF_OPTS += -Dzlib=disabled
endif

$(eval $(meson-package))
