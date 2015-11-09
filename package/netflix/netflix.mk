################################################################################
#
# netflix
#
################################################################################

NETFLIX_VERSION = 9600887bb2b2ed82370bfee3aed8eb6b70feb3d0
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

ifneq ($(NETFLIX_RESOURCE_LOC),)
define NETFLIX_RESOURCE_INSTALLATION
        mkdir -p $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/etc/conf/
        cat $(@D)/netflix/src/platform/gibbon/data/etc/conf/common.xml | awk -v h="etc" -v s="$(NETFLIX_RESOURCE_LOC)/etc" '{sub(h,s)}1' > $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/etc/conf/common.xml
        cat $(@D)/netflix/src/platform/gibbon/data/etc/conf/gibbon.xml | awk -v h="etc" -v s="$(NETFLIX_RESOURCE_LOC)/etc" '{sub(h,s)}1' > $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/etc/conf/gibbon.xml
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/etc/conf/graphics.xml $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/etc/conf/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/etc/conf/oem.xml $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/etc/conf/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/etc/conf/platform.xml $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/etc/conf/

        mkdir -p $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/etc/certs/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/etc/certs/ui_ca.pem $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/etc/certs/

        mkdir -p $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/etc/keys/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/etc/keys/appboot.key $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/etc/keys/

        mkdir -p $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/fonts/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/fonts/* $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/fonts/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/resources/gibbon/fonts/LastResort.ttf $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/fonts/

        # minimum set of resources to have some dynamic content
        mkdir -p $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/resources/js/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/resources/js/PartnerBridge.js $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/resources/js/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/resources/js/NetflixBridge.js $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/resources/js/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/resources/js/error.js $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/resources/js/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/resources/js/boot.js $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/resources/js/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/resources/js/splash.js $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/resources/js/

        mkdir -p $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/resources/img/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/resources/img/Netflix_Logo_Splash.png $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/resources/img/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/resources/img/Netflix_Background_Splash.png $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/resources/img/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/resources/img/Netflix_Shadow_Splash.png $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/resources/img/
        $(INSTALL) -m 444 $(@D)/netflix/src/platform/gibbon/data/resources/img/Spinner_Splash.mng $(TARGET_DIR)$(NETFLIX_RESOURCE_LOC)/resources/img/

        # fixes
        mkdir -p $(TARGET_DIR)/root/data/gibbon
endef
ifneq ($(NETFLIX_RESURCE_LOC),/root/data)
define NETFLIX_RESOURCE_LINKAGE
        cd $(TARGET_DIR) && rm -f root/data/fonts && ln -s $(NETFLIX_RESOURCE_LOC)/fonts/ root/data/fonts
        cd $(TARGET_DIR) && rm -f root/data/resources && ln -s $(NETFLIX_RESOURCE_LOC)/resources/ root/data/resources
endef
endif
endif

define NETFLIX_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/libJavaScriptCore.so $(TARGET_DIR)/usr/lib
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/netflix $(TARGET_DIR)/usr/bin
	$(NETFLIX_RESOURCE_INSTALLATION)
	$(NETFLIX_RESOURCE_LINKAGE)
endef

# To embed resources, I manually had to copy the resource files to get the build without errors. I did not test the embedded resources
#	-DBUILD_COMPILE_RESOURCES=0 \
#NETFLIX_CONFIGURE_CMDS = 												\
#	mkdir -p $(@D)/netflix/src/platform/gibbon/data/etc/conf; 							\
#	cp $(@D)/netflix/resources/configuration/common.xml $(@D)/netflix/src/platform/gibbon/data/etc/conf/common.xml;	\
#	cp $(@D)/netflix/resources/configuration/config.xml $(@D)/netflix/src/platform/gibbon/data/etc/conf/config.xml;	\
#	$(TARGET_MAKE_ENV); cmake $(NETFLIX_CONF_OPTS) $(@D)/netflix

$(eval $(cmake-package))
