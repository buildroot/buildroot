################################################################################
#
# python-pillow
#
################################################################################

PYTHON_PILLOW_VERSION = 10.0.0
PYTHON_PILLOW_SITE = https://files.pythonhosted.org/packages/0f/8b/2ebaf9adcf4260c00f842154865f8730cf745906aa5dd499141fb6063e26
PYTHON_PILLOW_SOURCE = Pillow-$(PYTHON_PILLOW_VERSION).tar.gz
PYTHON_PILLOW_LICENSE = HPND
PYTHON_PILLOW_LICENSE_FILES = LICENSE
PYTHON_PILLOW_CPE_ID_VENDOR = python
PYTHON_PILLOW_CPE_ID_PRODUCT = pillow
PYTHON_PILLOW_SETUP_TYPE = setuptools

PYTHON_PILLOW_DEPENDENCIES = host-pkgconf
PYTHON_PILLOW_BUILD_OPTS = build_ext --disable-platform-guessing
PYTHON_PILLOW_INSTALL_TARGET_OPTS = $(PYTHON_PILLOW_BUILD_OPTS)

ifeq ($(BR2_PACKAGE_FREETYPE),y)
PYTHON_PILLOW_DEPENDENCIES += freetype
PYTHON_PILLOW_BUILD_OPTS += --enable-freetype
else
PYTHON_PILLOW_BUILD_OPTS += --disable-freetype
endif

ifeq ($(BR2_PACKAGE_JPEG),y)
PYTHON_PILLOW_DEPENDENCIES += jpeg
PYTHON_PILLOW_BUILD_OPTS += --enable-jpeg
else
PYTHON_PILLOW_BUILD_OPTS += --disable-jpeg
endif

ifeq ($(BR2_PACKAGE_LCMS2),y)
PYTHON_PILLOW_DEPENDENCIES += lcms2
PYTHON_PILLOW_BUILD_OPTS += --enable-lcms
else
PYTHON_PILLOW_BUILD_OPTS += --disable-lcms
endif

ifeq ($(BR2_PACKAGE_LIBXCB),y)
PYTHON_PILLOW_DEPENDENCIES += libxcb
PYTHON_PILLOW_BUILD_OPTS += --enable-xcb
else
PYTHON_PILLOW_BUILD_OPTS += --disable-xcb
endif

ifeq ($(BR2_PACKAGE_OPENJPEG),y)
PYTHON_PILLOW_DEPENDENCIES += openjpeg
PYTHON_PILLOW_BUILD_OPTS += --enable-jpeg2000
else
PYTHON_PILLOW_BUILD_OPTS += --disable-jpeg2000
endif

ifeq ($(BR2_PACKAGE_TIFF),y)
PYTHON_PILLOW_DEPENDENCIES += tiff
PYTHON_PILLOW_BUILD_OPTS += --enable-tiff
else
PYTHON_PILLOW_BUILD_OPTS += --disable-tiff
endif

ifeq ($(BR2_PACKAGE_WEBP),y)
PYTHON_PILLOW_DEPENDENCIES += webp
PYTHON_PILLOW_BUILD_OPTS += --enable-webp
ifeq ($(BR2_PACKAGE_WEBP_DEMUX)$(BR2_PACKAGE_WEBP_MUX),yy)
PYTHON_PILLOW_BUILD_OPTS += --enable-webpmux
else
PYTHON_PILLOW_BUILD_OPTS += --disable-webpmux
endif
else
PYTHON_PILLOW_BUILD_OPTS += --disable-webp --disable-webpmux
endif

$(eval $(python-package))
