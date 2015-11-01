################################################################################
#
# netflix
#
################################################################################

NETFLIX_VERSION = a06cc1dd83ec52f3fb92411ad8fbd5ffc7e5f357
NETFLIX_SITE = git@github.com:Metrological/netflix.git
NETFLIX_SITE_METHOD = git
NETFLIX_LICENSE = PROPRIETARY
NETFLIX_DEPENDENCIES = freetype icu jpeg libpng libmng webp harfbuzz expat openssl c-ares libcurl graphite2
NETFLIX_INSTALL_STAGING = YES
NETFLIX_INSTALL_TARGET = YES
NETFLIX_SUBDIR = netflix

NETFLIX_CONF_OPTS = \
	-DBUILD_DPI_DIRECTORY=$(@D)/partner/dpi \
	-DCMAKE_BUILD_TYPE=Release \
	-DGIBBON_MODE=executable \
	-DGIBBON_INPUT=devinput

NETFLIX_CONF_ENV += \
	TARGET_CROSS="$(GNU_TARGET_NAME)-"

NETFLIX_FLAGS = \
	-fPIC

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=rpi-egl \
	-DGIBBON_PLATFORM=rpi
NRD_DEPENDENCIES += rpi-userland
else ifeq ($(BR2_PACKAGE_HAS_LIBEGL)$(BR2_PACKAGE_HAS_LIBGLES),yy)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2-egl \
	-DGIBBON_GRAPHICS=null
NRD_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2 \
	-DGIBBON_GRAPHICS=null
NRD_DEPENDENCIES += libgles
else
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=null \
	-DGIBBON_PLATFORM=posix
endif

ifeq ($(BR2_PACKAGE_GSTREAMER1),y)
NETFLIX_CONF_OPTS += -DDPI_IMPLEMENTATION=gstreamer
NETFLIX_DEPENDENCIES += gstreamer1
else ifeq ($(BR2_PACKAGE_HAS_LIBOPENMAX),y)
NETFLIX_CONF_OPTS += \
	-DDPI_IMPLEMENTATION=reference \
	-DDPI_REFERENCE_VIDEO_DECODER=openmax-il \
	-DDPI_REFERENCE_VIDEO_RENDERER=openmax-il \
	-DDPI_REFERENCE_AUDIO_DECODER=ffmpeg \
	-DDPI_REFERENCE_AUDIO_RENDERER=openmax-il \
	-DDPI_REFERENCE_AUDIO_MIXER=none
NETFLIX_DEPENDENCIES += ffmpeg openmax
else
NETFLIX_CONF_OPTS += -DDPI_IMPLEMENTATION=reference
endif

ifeq ($(BR2_PACKAGE_PLAYREADY),y)
NETFLIX_CONF_OPTS += -DDPI_REFERENCE_DRM=playready
NETFLIX_DEPENDENCIES += playready
else
NETFLIX_CONF_OPTS += -DDPI_REFERENCE_DRM=none
endif

NETFLIX_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(NETFLIX_FLAGS)" \
	-DCMAKE_CXX_FLAGS="$(NETFLIX_FLAGS)"

$(eval $(cmake-package))
