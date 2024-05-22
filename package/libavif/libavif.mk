################################################################################
#
# libavif
#
################################################################################

LIBAVIF_VERSION = 1.0.4
LIBAVIF_SITE = $(call github,AOMediaCodec,libavif,v$(LIBAVIF_VERSION))
LIBAVIF_LICENSE = BSD-2-Clause, IJG, Apache-2.0
LIBAVIF_LICENSE_FILES = LICENSE
LIBAVIF_INSTALL_STAGING = YES

# Only the dav1d decoder is packaged at the moment.
LIBAVIF_DEPENDENCIES = dav1d
LIBAVIF_CONF_OPTS = \
	-DAVIF_BUILD_APPS=OFF \
	-DAVIF_BUILD_EXAMPLES=OFF \
	-DAVIF_BUILD_MAN_PAGES=OFF \
	-DAVIF_BUILD_TESTS=OFF \
	-DAVIF_CODEC_AOM=OFF \
	-DAVIF_CODEC_DAV1D=ON \
	-DAVIF_CODEC_LIBGAV1=OFF \
	-DAVIF_CODEC_RAV1E=OFF \
	-DAVIF_CODEC_SVT=OFF \
	-DAVIF_CODEC_AVM=OFF \
	-DAVIF_ENABLE_GTEST=OFF

# There is no CMake options to explicitly enable/disable usage of
# libyuv, only autodetection :-(
ifeq ($(BR2_PACKAGE_LIBYUV),y)
LIBAVIF_DEPENDENCIES += libyuv
endif

$(eval $(cmake-package))
