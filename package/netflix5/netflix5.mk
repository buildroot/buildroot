################################################################################
#
# netflix5
#
################################################################################

NETFLIX5_VERSION = 3b48ee3950522a08f28a84a2cb4a51d493fa0d69

NETFLIX5_SITE = git@github.com:Metrological/netflix.git
NETFLIX5_SITE_METHOD = git
NETFLIX5_LICENSE = PROPRIETARY
NETFLIX5_DEPENDENCIES = freetype icu jpeg libpng libmng webp harfbuzz expat openssl c-ares libcurl graphite2 nghttp2 wpeframework gst1-plugins-base wpeframework-plugins
NETFLIX5_INSTALL_TARGET = YES
NETFLIX5_SUBDIR = netflix
NETFLIX5_RESOURCE_LOC = $(call qstrip,${BR2_PACKAGE_NETFLIX5_RESOURCE_LOCATION})

NETFLIX5_CONF_ENV += TOOLCHAIN_DIRECTORY=$(STAGING_DIR)/usr LD=$(TARGET_CROSS)ld
NETFLIX_CONF_ENV += TARGET_CROSS="$(GNU_TARGET_NAME)-"

ifeq ($(BR2_PACKAGE_PLAYREADY), y)
NETFLIX5_DEPENDENCIES += playready
endif
# TODO: check if all args are really needed.
NETFLIX5_CONF_OPTS = \
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
	-DNRDP_TOOLS="provisioning" \
	-DDPI_IMPLEMENTATION=sink-interface \
	-DDPI_SINK_INTERFACE_IMPLEMENTATION=gstreamer \
	-DBUILD_DEBUG=OFF -DNRDP_HAS_GIBBON_QA=ON -DNRDP_HAS_MUTEX_STACK=ON -DNRDP_HAS_OBJECTCOUNT=ON \
	-DBUILD_PRODUCTION=OFF -DNRDP_HAS_QA=ON -DBUILD_SMALL=OFF -DBUILD_SYMBOLS=ON -DNRDP_HAS_TRACING=OFF \
	-DNRDP_CRASH_REPORTING=breakpad \
	-DDPI_SINK_INTERFACE_OVERRIDE_APPBOOT=ON \
	-DGIBBON_GRAPHICS_GL_WSYS=egl

ifeq ($(BR2_PACKAGE_NETFLIX5_LIB), y)	
NETFLIX5_INSTALL_STAGING = YES
NETFLIX5_CONF_OPTS += -DGIBBON_MODE=shared
NETFLIX5_FLAGS = -O3 -fPIC
else
NETFLIX5_CONF_OPTS += -DGIBBON_MODE=executable
endif

ifeq ($(BR2_PACKAGE_NETFLIX5_AUDIO_MIXER_SOFTWARE), y)
NETFLIX5_CONF_OPTS += -DNRDP_HAS_AUDIOMIXER=ON \
                      -DUSE_AUDIOMIXER_GST=ON
NETFLIX5_DEPENDENCIES += tremor
else ifeq ($(BR2_PACKAGE_NETFLIX5_AUDIO_MIXER_NEXUS), y)
NETFLIX5_CONF_OPTS += -DNRDP_HAS_AUDIOMIXER=ON \
                      -DUSE_AUDIOMIXER_NEXUS=ON
else
NETFLIX5_CONF_OPTS += -DNRDP_HAS_AUDIOMIXER=OFF
endif

ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yy)
NETFLIX5_CONF_OPTS += -DGIBBON_INPUT=wpeframework
NETFLIX5_DEPENDENCIES = wpeframework-plugins
else
NETFLIX5_CONF_OPTS += -DGIBBON_INPUT=devinput
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yn)
NETFLIX5_CONF_OPTS += -DUSE_NETFLIX_VIRTUAL_KEYBOARD=1
NETFLIX5_DEPENDENCIES += WPEFramework
endif

ifeq ($(BR2_PACKAGE_NETFLIX5_GST_GL),y)
  NETFLIX5_CONF_OPTS += -DGST_VIDEO_RENDERING=gl
else ifeq ($(BR2_PACKAGE_NETFLIX5_MARVEL),y)
  NETFLIX5_CONF_OPTS += -DGST_VIDEO_RENDERING=synaptics
  NETFLIX5_DEPENDENCIES += westeros westeros-sink
else ifeq ($(BR2_PACKAGE_NETFLIX5_WESTEROS_SINK),y)
  NETFLIX5_CONF_OPTS += -DGST_VIDEO_RENDERING=westeros
  NETFLIX5_DEPENDENCIES += westeros westeros-sink
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
NETFLIX5_CONF_OPTS += \
        -DGIBBON_GST_PLATFORM=rpi #TODO remove it once GIBBON_PLATFORM for rpi is ready
ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yy)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wpeframework
else ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yn)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wayland-egl 
else
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=rpi-egl
endif	
NETFLIX5_CONF_OPTS += \
#	-DGIBBON_PLATFORM=rpi //Enable once port platform layer
ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_GL)$(BR2_PACKAGE_NETFLIX5_WESTEROS_SINK),yn)
NETFLIX5_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=gl
else ifeq ($(BR2_PACKAGE_GST1_PLUGINS_DORNE),y)
NETFLIX5_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=horizon-fusion
endif

NETFLIX5_DEPENDENCIES += libgles libegl

else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yy)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wpeframework
else ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yn)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wayland-egl
else
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wpeframework \
	-DGST_VIDEO_RENDERING=bcm-nexus
endif	

NETFLIX5_CONF_OPTS += \
	-DGIBBON_PLATFORM=posix 
NETFLIX5_DEPENDENCIES += libgles libegl

ifeq ($(BR2_PACKAGE_HOMECAST_SDK),y)
NETFLIX5_CONF_OPTS += -DNO_NXCLIENT=1
endif
else ifeq ($(BR2_PACKAGE_INTELCE_SDK),y)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=intelce \
	-DGIBBON_PLATFORM=posix
NETFLIX5_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HORIZON_SDK),y)
NETFLIX5_CONF_OPTS += \
	-DNRDP_SCHEDULER_TYPE=rr \
	-DGIBBON_TCMALLOC=OFF \
	-DGIBBON_GRAPHICS=intelce \
	-DGIBBON_PLATFORM=posix \
	-DDPI_REFERENCE_HAVE_DDPLUS=true
ifeq ($(BR2_PACKAGE_GST1_PLUGINS_DORNE),y)
NETFLIX5_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=horizon-fusion
endif
NETFLIX5_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_KYLIN_GRAPHICS),y)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wayland-egl \
	-DGIBBON_PLATFORM=posix 
NETFLIX5_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_LIBEGL)$(BR2_PACKAGE_HAS_LIBGLES)$(BR2_PACKAGE_MESA3D),yyn)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2-egl \
	-DGIBBON_PLATFORM=posix
NETFLIX5_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_LIBEGL)$(BR2_PACKAGE_HAS_LIBGLES)$(BR2_PACKAGE_MESA3D),yyy)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2-mesa \
	-DGIBBON_PLATFORM=posix
NETFLIX5_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2 \
	-DGIBBON_PLATFORM=posix
NETFLIX5_DEPENDENCIES += libgles
else
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=null \
	-DGIBBON_PLATFORM=posix
endif

#
# ifeq ($(BR2_PACKAGE_GSTREAMER1),y)
# NETFLIX5_CONF_OPTS += -DDPI_IMPLEMENTATION=gstreamer
# NETFLIX5_DEPENDENCIES += gstreamer1 gst1-plugins-base gst1-plugins-bad
# else ifeq ($(BR2_PACKAGE_HAS_LIBOPENMAX),y)
# NETFLIX5_CONF_OPTS += \
# 	-DDPI_IMPLEMENTATION=reference \
# 	-DDPI_REFERENCE_VIDEO_DECODER=openmax-il \
# 	-DDPI_REFERENCE_VIDEO_RENDERER=openmax-il \
# 	-DDPI_REFERENCE_AUDIO_DECODER=ffmpeg \
# 	-DDPI_REFERENCE_AUDIO_RENDERER=openmax-il \
# 	-DDPI_REFERENCE_AUDIO_MIXER=none
# NETFLIX5_DEPENDENCIES += ffmpeg libopenmax
# else
# NETFLIX5_CONF_OPTS += -DDPI_IMPLEMENTATION=reference
# endif

# ifeq ($(BR2_PACKAGE_PLAYREADY),y)
#     NETFLIX5_CONF_OPTS += -DDPI_REFERENCE_DRM=playready
#     NETFLIX5_DEPENDENCIES += playready
# else
#     NETFLIX5_CONF_OPTS += -DDPI_REFERENCE_DRM=none
# endif

ifeq ($(BR2_PACKAGE_CPPSDK),y)
    # This path is deprecated, but for legacy still applicable.
    ifeq ($(BR2_PACKAGE_LIBPROVISION),y)
        NETFLIX5_CONF_OPTS += -DNETFLIX_USE_PROVISION=ON
        NETFLIX5_DEPENDENCIES += libprovision
    endif
    ifeq ($(BR2_PACKAGE_GLUELOGIC_VIRTUAL_KEYBOARD),y)
        NETFLIX5_CONF_OPTS += -DUSE_NETFLIX_VIRTUAL_KEYBOARD=1
        NETFLIX5_DEPENDENCIES += gluelogic
    endif
else
    ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROVISIONPROXY), y)
        NETFLIX5_CONF_OPTS += -DNETFLIX_USE_PROVISION=ON
        NETFLIX5_DEPENDENCIES += wpeframework
    endif
    ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT),y)
        NETFLIX5_CONF_OPTS += -DUSE_NETFLIX_VIRTUAL_KEYBOARD=1
        NETFLIX5_DEPENDENCIES += wpeframework
    endif
endif

ifneq ($(BR2_PACKAGE_NETFLIX5_KEYMAP),"")
NETFLIX5_CONF_OPTS += -DNETFLIX_USE_KEYMAP=$(call qstrip,$(BR2_PACKAGE_NETFLIX5_KEYMAP))
endif

NETFLIX5_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(NETFLIX5_FLAGS)" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(NETFLIX5_FLAGS)"

define NETFLIX5_FIX_CONFIG_XMLS
	mkdir -p $(@D)/netflix/src/platform/gibbon/data/etc/conf
	cp -f $(@D)/netflix/resources/configuration/common.xml $(@D)/netflix/src/platform/gibbon/data/etc/conf/common.xml
	cp -f $(@D)/netflix/resources/configuration/config.xml $(@D)/netflix/src/platform/gibbon/data/etc/conf/config.xml
endef

NETFLIX5_POST_EXTRACT_HOOKS += NETFLIX5_FIX_CONFIG_XMLS

ifeq ($(BR2_PACKAGE_NETFLIX5_LIB),y)

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),y)
define NETFLIX5_INSTALL_WPEFRAMEWORK_XML
	cp $(@D)/partner/graphics/wpeframework/graphics.xml $(TARGET_DIR)/root/Netflix/etc/conf
endef
endif

define NETFLIX5_INSTALL_STAGING_CMDS
	make -C $(@D)/netflix install
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/libnetflix.so $(STAGING_DIR)/usr/lib
	$(INSTALL) -D package/netflix5/netflix.pc $(STAGING_DIR)/usr/lib/pkgconfig/netflix.pc
	mkdir -p $(STAGING_DIR)/usr/include/netflix/src
	mkdir -p $(STAGING_DIR)/usr/include/netflix/nrdbase
	mkdir -p $(STAGING_DIR)/usr/include/netflix/nrd
	mkdir -p $(STAGING_DIR)/usr/include/netflix/nrdnet
	cp -Rpf $(@D)/release/include/* $(STAGING_DIR)/usr/include/netflix/
	cp -Rpf $(@D)/netflix/include/nrdbase/*.h $(STAGING_DIR)/usr/include/netflix/nrdbase/
	cp -Rpf $(@D)/netflix/include/nrd/*.h $(STAGING_DIR)/usr/include/netflix/nrd/
	cp -Rpf $(@D)/netflix/include/nrdnet/*.h $(STAGING_DIR)/usr/include/netflix/nrdnet/
	cd $(@D)/netflix/src && find ./base/ -name "*.h" -exec cp --parents {} ${STAGING_DIR}/usr/include/netflix/src \;
	cd $(@D)/netflix/src && find ./nrd/ -name "*.h" -exec cp --parents {} ${STAGING_DIR}/usr/include/netflix/src \;
	cd $(@D)/netflix/src && find ./net/ -name "*.h" -exec cp --parents {} ${STAGING_DIR}/usr/include/netflix/src \;
	mkdir -p $(STAGING_DIR)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/*.h $(STAGING_DIR)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/bridge/*.h $(STAGING_DIR)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/text/*.h $(STAGING_DIR)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/text/freetype/*.h $(STAGING_DIR)/usr/include/netflix
	mkdir -p $(STAGING_DIR)/usr/include/netflix/gibbon
	cp -Rpf $(@D)/netflix/src/platform/gibbon/include/gibbon/*.h $(STAGING_DIR)/usr/include/netflix/gibbon
	find $(STAGING_DIR)/usr/include/netflix/nrdbase/ -name "*.h" -exec sed -i "s/^#include \"\.\.\/\.\.\//#include \"/g" {} \;
	find $(STAGING_DIR)/usr/include/netflix/nrd/ -name "*.h" -exec sed -i "s/^#include \"\.\.\/\.\.\//#include \"/g" {} \;
	find $(STAGING_DIR)/usr/include/netflix/nrdnet/ -name "*.h" -exec sed -i "s/^#include \"\.\.\/\.\.\//#include \"/g" {} \;

	mkdir -p $(TARGET_DIR)/root/Netflix
	cp -r $(@D)/netflix/src/platform/gibbon/resources/gibbon/fonts $(TARGET_DIR)/root/Netflix
	cp -r $(@D)/netflix/resources/etc $(TARGET_DIR)/root/Netflix
	mkdir -p $(TARGET_DIR)/root/Netflix/etc/conf
	cp -r $(@D)/netflix/src/platform/gibbon/resources/configuration/* $(TARGET_DIR)/root/Netflix/etc/conf
	cp -r $(@D)/netflix/src/platform/gibbon/resources/gibbon/icu $(TARGET_DIR)/root/Netflix
	cp -r $(@D)/netflix/src/platform/gibbon/resources $(TARGET_DIR)/root/Netflix
	cp -r $(@D)/netflix/resources/configuration/* $(TARGET_DIR)/root/Netflix/etc/conf

        $(NETFLIX5_INSTALL_WPEFRAMEWORK_XML)
	cp $(@D)/netflix/src/platform/gibbon/resources/gibbon/icu/icudt58l/debug/unames.icu $(TARGET_DIR)/root/Netflix/icu/icudt58l
	cp $(@D)/netflix/src/platform/gibbon/*.js* $(TARGET_DIR)/root/Netflix/resources/js
	cp $(@D)/netflix/src/platform/gibbon/resources/default/PartnerBridge.js $(TARGET_DIR)/root/Netflix/resources/js
endef

define NETFLIX5_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/libnetflix.so $(TARGET_DIR)/usr/lib
	$(STRIPCMD) $(TARGET_DIR)/usr/lib/libnetflix.so
endef

else

define NETFLIX5_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/netflix $(TARGET_DIR)/usr/bin
endef

endif

define NETFLIX5_PREPARE_DPI
	mkdir -p $(TARGET_DIR)/root/Netflix/dpi
	ln -sfn /etc/playready $(TARGET_DIR)/root/Netflix/dpi/playready
endef

NETFLIX5_POST_INSTALL_TARGET_HOOKS += NETFLIX5_PREPARE_DPI

$(eval $(cmake-package))
