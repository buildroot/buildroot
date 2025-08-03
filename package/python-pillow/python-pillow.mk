################################################################################
#
# python-pillow
#
################################################################################

PYTHON_PILLOW_VERSION = 11.3.0
PYTHON_PILLOW_SITE = https://files.pythonhosted.org/packages/f3/0d/d0d6dea55cd152ce3d6767bb38a8fc10e33796ba4ba210cbab9354b6d238
PYTHON_PILLOW_SOURCE = pillow-$(PYTHON_PILLOW_VERSION).tar.gz
PYTHON_PILLOW_LICENSE = HPND
PYTHON_PILLOW_LICENSE_FILES = LICENSE
PYTHON_PILLOW_CPE_ID_VENDOR = python
PYTHON_PILLOW_CPE_ID_PRODUCT = pillow
PYTHON_PILLOW_SETUP_TYPE = setuptools

PYTHON_PILLOW_DEPENDENCIES = host-pkgconf
PYTHON_PILLOW_BUILD_OPTS = \
	-Cplatform-guessing=disable \
	-Cimagequant=disable \
	-Craqm=disable

ifeq ($(BR2_PACKAGE_FREETYPE),y)
PYTHON_PILLOW_DEPENDENCIES += freetype
PYTHON_PILLOW_BUILD_OPTS += -Cfreetype=enable
else
PYTHON_PILLOW_BUILD_OPTS += -Cfreetype=disable
endif

ifeq ($(BR2_PACKAGE_JPEG),y)
PYTHON_PILLOW_DEPENDENCIES += jpeg
PYTHON_PILLOW_BUILD_OPTS += -Cjpeg=enable
else
PYTHON_PILLOW_BUILD_OPTS += -Cjpeg=disable
endif

ifeq ($(BR2_PACKAGE_LCMS2),y)
PYTHON_PILLOW_DEPENDENCIES += lcms2
PYTHON_PILLOW_BUILD_OPTS += -Clcms=enable
else
PYTHON_PILLOW_BUILD_OPTS += -Clcms=disable
endif

ifeq ($(BR2_PACKAGE_LIBXCB),y)
PYTHON_PILLOW_DEPENDENCIES += libxcb
PYTHON_PILLOW_BUILD_OPTS += -Cxcb=enable
else
PYTHON_PILLOW_BUILD_OPTS += -Cxcb=disable
endif

ifeq ($(BR2_PACKAGE_OPENJPEG),y)
PYTHON_PILLOW_DEPENDENCIES += openjpeg
PYTHON_PILLOW_BUILD_OPTS += -Cjpeg2000=enable
else
PYTHON_PILLOW_BUILD_OPTS += -Cjpeg2000=disable
endif

ifeq ($(BR2_PACKAGE_TIFF),y)
PYTHON_PILLOW_DEPENDENCIES += tiff
PYTHON_PILLOW_BUILD_OPTS += -Ctiff=enable
else
PYTHON_PILLOW_BUILD_OPTS += -Ctiff=disable
endif

ifeq ($(BR2_PACKAGE_WEBP)$(BR2_PACKAGE_WEBP_DEMUX)$(BR2_PACKAGE_WEBP_MUX),yyy)
PYTHON_PILLOW_DEPENDENCIES += webp
PYTHON_PILLOW_BUILD_OPTS += -Cwebp=enable
else
PYTHON_PILLOW_BUILD_OPTS += -Cwebp=disable
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
PYTHON_PILLOW_DEPENDENCIES += zlib
PYTHON_PILLOW_BUILD_OPTS += -Czlib=enable
else
PYTHON_PILLOW_BUILD_OPTS += -Czlib=disable
endif

$(eval $(python-package))
