################################################################################
#
# netflix
#
################################################################################

NETFLIX_VERSION = 77a8648c5b8b69631b668c9953bd88ee839e9931
NETFLIX_SITE = git@github.com:Metrological/netflix.git
NETFLIX_SITE_METHOD = git
NETFLIX_LICENSE = PROPRIETARY
NETFLIX_DEPENDENCIES = freetype icu jpeg libpng libmng webp harfbuzz expat openssl c-ares libcurl graphite2
NETFLIX_INSTALL_TARGET = YES
NETFLIX_SUBDIR = netflix
NETFLIX_RESOURCE_LOC = $(call qstrip,${BR2_PACKAGE_NETFLIX_RESOURCE_LOCATION})

NETFLIX_CONF_OPTS = \
	-DBUILD_DPI_DIRECTORY=$(@D)/partner/dpi \
	-DCMAKE_INSTALL_PREFIX=$(@D)/release \
	-DCMAKE_OBJCOPY="$(TARGET_CROSS)objcopy" \
	-DCMAKE_STRIP="$(TARGET_CROSS)strip" \
	-DBUILD_COMPILE_RESOURCES=ON \
	-DBUILD_SYMBOLS=OFF \
	-DBUILD_SHARED_LIBS=OFF \
	-DGIBBON_SCRIPT_JSC_DYNAMIC=OFF \
	-DGIBBON_SCRIPT_JSC_DEBUG=OFF \
	-DNRDP_HAS_IPV6=ON \
	-DNRDP_CRASH_REPORTING="off" \
	-DNRDP_TOOLS="manufSSgenerator"

ifeq ($(BR2_ENABLE_DEBUG),y)
NETFLIX_CONF_OPTS += \
	-DCMAKE_BUILD_TYPE=Debug \
	-DBUILD_DEBUG=ON \
	-DBUILD_PRODUCTION=OFF
else
NETFLIX_CONF_OPTS += \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_DEBUG=OFF \
	-DBUILD_PRODUCTION=ON
endif

ifeq ($(BR2_PACKAGE_NETFLIX_LIB), y)
NETFLIX_INSTALL_STAGING = YES
NETFLIX_CONF_OPTS += -DGIBBON_MODE=shared
NETFLIX_FLAGS = -O3 -fPIC
else
NETFLIX_CONF_OPTS += -DGIBBON_MODE=executable
endif

NETFLIX_CONF_ENV += TARGET_CROSS="$(GNU_TARGET_NAME)-"

ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yy)
NETFLIX_CONF_OPTS += -DGIBBON_INPUT=wpeframework
NETFLIX_DEPENDENCIES = wpeframework-compositor
else
NETFLIX_CONF_OPTS += -DGIBBON_INPUT=devinput
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yn)
NETFLIX_CONF_OPTS += -DUSE_NETFLIX_VIRTUAL_KEYBOARD=1
NETFLIX_DEPENDENCIES += WPEFramework
endif

ifeq ($(BR2_PACKAGE_NETFLIX_GST_GL),y)
NETFLIX_CONF_OPTS += -DGST_VIDEO_RENDERING=gl
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)

ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yy)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wpeframework
else ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yn)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wayland-egl
else
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=rpi-egl
endif	
NETFLIX_CONF_OPTS += \
	-DGIBBON_PLATFORM=rpi
ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_GL),y)
NETFLIX_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=gl
else ifeq ($(BR2_PACKAGE_GST1_PLUGINS_DORNE),y)
NETFLIX_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=horizon-fusion
endif

NETFLIX_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yy)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wpeframework
else ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yn)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wayland-egl
else
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=nexus \
	-DGST_VIDEO_RENDERING=bcm-nexus
endif	
NETFLIX_CONF_OPTS += \
	-DGIBBON_PLATFORM=posix 
NETFLIX_DEPENDENCIES += libgles libegl

ifeq ($(BR2_PACKAGE_HOMECAST_SDK),y)
NETFLIX_CONF_OPTS += -DNO_NXCLIENT=1
endif
else ifeq ($(BR2_PACKAGE_INTELCE_SDK),y)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=intelce \
	-DGIBBON_PLATFORM=posix
NETFLIX_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HORIZON_SDK),y)
NETFLIX_CONF_OPTS += \
	-DNRDP_SCHEDULER_TYPE=rr \
	-DGIBBON_TCMALLOC=OFF \
	-DGIBBON_GRAPHICS=intelce \
	-DGIBBON_PLATFORM=posix \
	-DDPI_REFERENCE_HAVE_DDPLUS=true
ifeq ($(BR2_PACKAGE_GST1_PLUGINS_DORNE),y)
NETFLIX_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=horizon-fusion
endif
NETFLIX_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_KYLIN_GRAPHICS),y)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wayland-egl \
	-DGIBBON_PLATFORM=posix 
NETFLIX_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_LIBEGL)$(BR2_PACKAGE_HAS_LIBGLES)$(BR2_PACKAGE_MESA3D),yyn)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2-egl \
	-DGIBBON_PLATFORM=posix
NETFLIX_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_LIBEGL)$(BR2_PACKAGE_HAS_LIBGLES)$(BR2_PACKAGE_MESA3D),yyy)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2-mesa \
	-DGIBBON_PLATFORM=posix
NETFLIX_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2 \
	-DGIBBON_PLATFORM=posix
NETFLIX_DEPENDENCIES += libgles
else
NETFLIX_CONF_OPTS += \
	-DGIBBON_GRAPHICS=null \
	-DGIBBON_PLATFORM=posix
endif

ifeq ($(BR2_PACKAGE_GSTREAMER1),y)
NETFLIX_CONF_OPTS += -DDPI_IMPLEMENTATION=gstreamer
NETFLIX_DEPENDENCIES += gstreamer1 gst1-plugins-base gst1-plugins-bad
else ifeq ($(BR2_PACKAGE_HAS_LIBOPENMAX),y)
NETFLIX_CONF_OPTS += \
	-DDPI_IMPLEMENTATION=reference \
	-DDPI_REFERENCE_VIDEO_DECODER=openmax-il \
	-DDPI_REFERENCE_VIDEO_RENDERER=openmax-il \
	-DDPI_REFERENCE_AUDIO_DECODER=ffmpeg \
	-DDPI_REFERENCE_AUDIO_RENDERER=openmax-il \
	-DDPI_REFERENCE_AUDIO_MIXER=none
NETFLIX_DEPENDENCIES += ffmpeg libopenmax
else
NETFLIX_CONF_OPTS += -DDPI_IMPLEMENTATION=reference
endif

ifeq ($(BR2_PACKAGE_PLAYREADY),y)
    NETFLIX_CONF_OPTS += -DDPI_REFERENCE_DRM=playready
    NETFLIX_DEPENDENCIES += playready
else
    NETFLIX_CONF_OPTS += -DDPI_REFERENCE_DRM=none
endif

ifeq ($(BR2_PACKAGE_CPPSDK),y)
    # This path is deprecated, but for legacy still applicable.
    ifeq ($(BR2_PACKAGE_LIBPROVISION),y)
        NETFLIX_CONF_OPTS += -DNETFLIX_USE_PROVISION=ON
        NETFLIX_DEPENDENCIES += libprovision
    endif
    ifeq ($(BR2_PACKAGE_GLUELOGIC_VIRTUAL_KEYBOARD),y)
        NETFLIX_CONF_OPTS += -DUSE_NETFLIX_VIRTUAL_KEYBOARD=1
        NETFLIX_DEPENDENCIES += gluelogic
    endif
else
    ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROVISIONPROXY), y)
        NETFLIX_CONF_OPTS += -DNETFLIX_USE_PROVISION=ON
        NETFLIX_DEPENDENCIES += wpeframework
    endif
    ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT),y)
        NETFLIX_CONF_OPTS += -DUSE_NETFLIX_VIRTUAL_KEYBOARD=1
        NETFLIX_DEPENDENCIES += wpeframework
    endif
endif

ifneq ($(BR2_PACKAGE_NETFLIX_KEYMAP),"")
NETFLIX_CONF_OPTS += -DNETFLIX_USE_KEYMAP=$(call qstrip,$(BR2_PACKAGE_NETFLIX_KEYMAP))
endif

NETFLIX_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(NETFLIX_FLAGS)" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(NETFLIX_FLAGS)"

define NETFLIX_FIX_CONFIG_XMLS
	mkdir -p $(@D)/netflix/src/platform/gibbon/data/etc/conf
	cp -f $(@D)/netflix/resources/configuration/common.xml $(@D)/netflix/src/platform/gibbon/data/etc/conf/common.xml
	cp -f $(@D)/netflix/resources/configuration/config.xml $(@D)/netflix/src/platform/gibbon/data/etc/conf/config.xml
endef

NETFLIX_POST_EXTRACT_HOOKS += NETFLIX_FIX_CONFIG_XMLS

ifeq ($(BR2_PACKAGE_NETFLIX_LIB),y)

define NETFLIX_INSTALL_STAGING_CMDS
	make -C $(@D)/netflix install
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/libnetflix.so $(STAGING_DIR)/usr/lib
	$(INSTALL) -D package/netflix/netflix.pc $(STAGING_DIR)/usr/lib/pkgconfig/netflix.pc
	mkdir -p $(STAGING_DIR)/usr/include/netflix
	cp -Rpf $(@D)/release/include/* $(STAGING_DIR)/usr/include/netflix/
	cp -Rpf $(@D)/netflix/include/nrdbase/config.h $(STAGING_DIR)/usr/include/netflix/nrdbase/
	mkdir -p $(STAGING_DIR)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/*.h $(STAGING_DIR)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/bridge/*.h $(STAGING_DIR)/usr/include/netflix
	mkdir -p $(STAGING_DIR)/usr/include/netflix/gibbon
	cp -Rpf $(@D)/netflix/src/platform/gibbon/include/gibbon/*.h $(STAGING_DIR)/usr/include/netflix/gibbon
	$(SED) 's:^using std\:\:isnan;:\/\/using std\:\:isnan;:' \
		-e 's:^using std\:\:isinf:\/\/using std\:\:isinf:' \
		$(STAGING_DIR)/usr/include/netflix/nrdbase/tr1.h
endef

define NETFLIX_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/libnetflix.so $(TARGET_DIR)/usr/lib
endef

else

define NETFLIX_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/netflix $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/manufss $(TARGET_DIR)/usr/bin
endef

endif

$(eval $(cmake-package))
