################################################################################
#
# netflix
#
################################################################################

NETFLIX_VERSION = 2492376771e092e66c35fdba088e957bc125dadc
NETFLIX_SITE = git@github.com:Metrological/netflix.git
NETFLIX_SITE_METHOD = git
NETFLIX_LICENSE = PROPRIETARY
NETFLIX_DEPENDENCIES = freetype icu jpeg libpng libmng webp harfbuzz expat openssl c-ares libcurl graphite2
NETFLIX_INSTALL_TARGET = YES
NETFLIX_SUBDIR = netflix
NETFLIX_RESOURCE_LOC = $(call qstrip,${BR2_PACKAGE_NETFLIX_RESOURCE_LOCATION})

NETFLIX_CONF_OPTS = \
	-DBUILD_DPI_DIRECTORY=$(@D)/partner/dpi \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/netflix \
	-DBUILD_COMPILE_RESOURCES=1 \
	-DNRDP_HAS_IPV6=0 \
	-DBUILD_SHARED_LIBS=0 \
	-DGIBBON_MODE=executable \
	-DGIBBON_SCRIPT_JSC_DYNAMIC=1 \
	-DGIBBON_SCRIPT_JSC_DEBUG=0 \
	-DGIBBON_INPUT=devinput \
	-DNRDP_TOOLS="manufSSgenerator"

NETFLIX_CONF_ENV += \
	TARGET_CROSS="$(GNU_TARGET_NAME)-"

NETFLIX_FLAGS = \
	-fPIC

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=rpi-egl \
	-DGIBBON_PLATFORM=rpi
NRD_DEPENDENCIES += rpi-userland
else ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=nexus \
	-DGIBBON_PLATFORM=posix
NRD_DEPENDENCIES += bcm-refsw
else ifeq ($(BR2_PACKAGE_HAS_LIBEGL)$(BR2_PACKAGE_HAS_LIBGLES),yy)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2-egl \
	-DGIBBON_PLATFORM=posix
NRD_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2 \
	-DGIBBON_PLATFORM=posix
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

define NETFLIX_FIX_CONFIG_XMLS
	mkdir -p $(@D)/netflix/src/platform/gibbon/data/etc/conf
	cp -f $(@D)/netflix/resources/configuration/common.xml $(@D)/netflix/src/platform/gibbon/data/etc/conf/common.xml
	cp -f $(@D)/netflix/resources/configuration/config.xml $(@D)/netflix/src/platform/gibbon/data/etc/conf/config.xml
endef

NETFLIX_POST_EXTRACT_HOOKS += NETFLIX_FIX_CONFIG_XMLS

define NETFLIX_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/libJavaScriptCore.so $(TARGET_DIR)/usr/lib
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/netflix $(TARGET_DIR)/usr/bin
	mkdir -p $(TARGET_DIR)/usr/share/fonts/netflix
	$(INSTALL) -m 644 $(@D)/netflix/src/platform/gibbon/data/fonts/* $(TARGET_DIR)/usr/share/fonts/netflix/
	$(INSTALL) -m 644 $(@D)/netflix/src/platform/gibbon/resources/gibbon/fonts/LastResort.ttf $(TARGET_DIR)/usr/share/fonts/netflix/
endef

$(eval $(cmake-package))
