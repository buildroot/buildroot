################################################################################
#
# netflix5
#
################################################################################

NETFLIX5_VERSION = cf9bbeb8b00443e5f3aa600984b277892c89ec72
NETFLIX5_SITE = git@github.com:Metrological/netflix.git
NETFLIX5_SITE_METHOD = git
NETFLIX5_LICENSE = PROPRIETARY
NETFLIX5_DEPENDENCIES = freetype icu jpeg libpng libmng webp harfbuzz expat openssl c-ares nghttp2 libcurl graphite2 tremor
NETFLIX5_INSTALL_TARGET = YES
NETFLIX5_SUBDIR = netflix
NETFLIX5_RESOURCE_LOC = $(call qstrip,${BR2_PACKAGE_NETFLIX5_RESOURCE_LOCATION})

NETFLIX5_CONF_ENV += TOOLCHAIN_DIRECTORY=$(STAGING_DIR)/usr LD=$(TARGET_CROSS)ld
NETFLIX5_CONF_ENV += TARGET_CROSS="$(GNU_TARGET_NAME)-"

NETFLIX5_CONF_OPTS += -DBUILD_REFERENCE=${NETFLIX5_VERSION}
NETFLIX5_SUPPORTS_IN_SOURCE_BUILD = NO

# TODO: check if all args are really needed.
NETFLIX5_CONF_OPTS = \
	-DBUILD_DPI_DIRECTORY=$(@D)/partner/dpi \
	-DCMAKE_OBJCOPY="$(TARGET_CROSS)objcopy" \
	-DCMAKE_STRIP="$(TARGET_CROSS)strip" \
	-DBUILD_COMPILE_RESOURCES=OFF \
	-DBUILD_SHARED_LIBS=OFF \
	-DNRDP_HAS_IPV6=ON \
	-DGIBBON_GRAPHICS_GL_WSYS=egl

NETFLIX5_CONF_ENV += \
	NODE="$(HOST_DIR)/usr/bin/node" \
	NPM="$(HOST_DIR)/usr/bin/npm" \
	
ifeq ($(BR2_PACKAGE_NETFLIX5_BUILD_ML),y)
NETFLIX5_CONF_OPTS += \
	-DBUILD_COMPILE_RESOURCES=ON \
	-DNRDP_CRASH_REPORTING=breakpad \
	-DBUILD_DEBUG=OFF \
	-DNRDP_HAS_GIBBON_QA=ON \
	-DNRDP_HAS_MUTEX_STACK=ON \
	-DNRDP_HAS_OBJECTCOUNT=ON \
	-DBUILD_PRODUCTION=OFF \
	-DNRDP_HAS_QA=OFF \
	-DBUILD_SMALL=OFF \
	-DBUILD_SYMBOLS=ON \
	-DNRDP_HAS_TRACING=OFF
else ifeq ($(BR2_PACKAGE_NETFLIX5_BUILD_DEBUG),y)
NETFLIX5_CONF_OPTS += \
	-DBUILD_DEBUG=ON \
	-DBUILD_SMALL=OFF \
	-DBUILD_STRIP=OFF \
	-DBUILD_SYMBOLS=ON \
	-DBUILD_PRODUCTION=OFF \
	-DNRDP_HAS_GIBBON_QA=ON \
	-DNRDP_HAS_MUTEX_STACK=ON \
	-DNRDP_HAS_OBJECTCOUNT=ON \
	-DNRDP_HAS_QA=ON \
	-DNRDP_HAS_TRACING=ON 
else ifeq ($(BR2_PACKAGE_NETFLIX5_BUILD_RELEASE_DEBUG),y)
NETFLIX5_CONF_OPTS += \
	-DBUILD_DEBUG=OFF \
	-DBUILD_PRODUCTION=ON \
	-DBUILD_SMALL=OFF \
	-DBUILD_STRIP=OFF \
	-DBUILD_SYMBOLS=ON \
	-DNRDP_HAS_GIBBON_QA=ON \
	-DNRDP_HAS_MUTEX_STACK=ON \
	-DNRDP_HAS_OBJECTCOUNT=ON \
	-DNRDP_HAS_QA=OFF \
	-DNRDP_HAS_TRACING=ON 
else ifeq ($(BR2_PACKAGE_NETFLIX5_BUILD_RELEASE),y)
NETFLIX5_CONF_OPTS += \
	-DBUILD_DEBUG=OFF \
	-DBUILD_PRODUCTION=ON \
	-DBUILD_SMALL=OFF \
	-DBUILD_STRIP=OFF \
	-DBUILD_SYMBOLS=OFF \
	-DNRDP_HAS_GIBBON_QA=OFF \
	-DNRDP_HAS_MUTEX_STACK=OFF \
	-DNRDP_HAS_OBJECTCOUNT=ON \
	-DNRDP_HAS_QA=OFF \
	-DNRDP_HAS_TRACING=OFF 
endif

ifeq ($(BR2_PACKAGE_VSS_SDK),y)
NETFLIX5_CONF_OPTS += \
	-DUSE_DISPLAY_SETTINGS=1
endif

ifeq ($(BR2_PACKAGE_NETFLIX5_MINIFY_JS),y)
NETFLIX5_CONF_OPTS += \
		-DJS_MINIFY=ON
NETFLIX5_DEPENDENCIES += \
		host-nodejs
		
define NETFLIX5_INSTALL_NODEJS_MODULES
	npm_config_build_from_source=true \
	npm_config_nodedir=$(BUILD_DIR)/host-nodejs-$(NODEJS_VERSION) \
	npm_config_prefix=$(HOST_DIR)/usr \
	$(HOST_DIR)/usr/bin/npm  install -g uglify-es@3.0.28 jsdoc
endef

NETFLIX5_PRE_CONFIGURE_HOOKS += NETFLIX5_INSTALL_NODEJS_MODULES
endif

ifeq ($(BR2_PACKAGE_NETFLIX5_DISABLE_TOOLS), y)
NETFLIX5_CONF_OPTS += \
	-DNRDP_TOOLS=none
else
NETFLIX5_CONF_OPTS += \
	-DNRDP_TOOLS="provisioning"
endif

NETFLIX5_CONF_OPTS += \
	-DDPI_IMPLEMENTATION=gstreamer

NETFLIX5_DEPENDENCIES += gstreamer1 gst1-plugins-base gst1-plugins-bad

ifeq ($(BR2_PACKAGE_NETFLIX5_DRM_OCDM), y)
NETFLIX5_CONF_OPTS += \
	-DDPI_DRM=ocdm
else ifeq ($(BR2_PACKAGE_NETFLIX5_DRM_PLAYREADY), y)
NETFLIX5_DEPENDENCIES += playready
NETFLIX5_CONF_OPTS += \
        -DDPI_DRM=playready2.5
endif

ifeq ($(BR2_PACKAGE_NETFLIX5_LIB), y)
NETFLIX5_INSTALL_STAGING = YES
NETFLIX5_CONF_OPTS += -DGIBBON_MODE=shared
NETFLIX5_FLAGS = -O3 -fPIC
else
NETFLIX5_CONF_OPTS += -DGIBBON_MODE=executable
endif

ifeq ($(BR2_PACKAGE_NETFLIX5_AUDIO_MIXER), y)
NETFLIX5_DEPENDENCIES += libogg tremor
ifeq ($(BR2_PACKAGE_NETFLIX5_AUDIO_MIXER_SOFTWARE), y)
NETFLIX5_CONF_OPTS += -DNRDP_HAS_AUDIOMIXER=ON \
                      -DUSE_AUDIOMIXER_GST=ON
else ifeq ($(BR2_PACKAGE_NETFLIX5_AUDIO_MIXER_NEXUS), y)
NETFLIX5_CONF_OPTS += -DNRDP_HAS_AUDIOMIXER=ON \
                      -DUSE_AUDIOMIXER_NEXUS=ON
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITORCLIENT),y)
NETFLIX5_CONF_OPTS += -DGIBBON_INPUT=wpeframework
NETFLIX5_DEPENDENCIES += wpeframework-plugins
else
NETFLIX5_CONF_OPTS += -DGIBBON_INPUT=devinput
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITORCLIENT),yn)
NETFLIX5_CONF_OPTS += -DUSE_NETFLIX_VIRTUAL_KEYBOARD=1
NETFLIX5_DEPENDENCIES += wpeframework
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
	-DGIBBON_PLATFORM=posix \
	-DGIBBON_GST_PLATFORM=rpi #TODO remove it once GIBBON_PLATFORM for rpi is ready

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITORCLIENT),y)
NETFLIX5_CONF_OPTS += \
        -DGIBBON_GRAPHICS=wpeframework
ifeq ($(BR2_PACKAGE_WESTEROS),) # WPEFramework for RPI platform supports only either westeros or rpi, hence set this flag
                                # to reuse EGL context in WPEFramework-rpi + GST_VIDEO_RENDERING=gl combination to avoid
                                # memory leak and crash during the suspend/resume
	NETFLIX5_CONF_OPTS += -DEGL_CONTEXT_REUSE=1
endif
else ifeq ($(BR2_PACKAGE_WESTEROS),y)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wayland \
	-DGIBBON_EVENTLOOP=virtualinput
else
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=rpi \
	-DGIBBON_EVENTLOOP=virtualinput
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_GL)$(BR2_PACKAGE_NETFLIX5_WESTEROS_SINK),yn)
NETFLIX5_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=gl
else ifeq ($(BR2_PACKAGE_GST1_PLUGINS_DORNE),y)
NETFLIX5_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=horizon-fusion
endif

NETFLIX5_DEPENDENCIES += libgles libegl

else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITORCLIENT),y)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wpeframework
else ifeq ($(BR2_PACKAGE_WESTEROS),y)
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wayland
else
NETFLIX5_CONF_OPTS += \
	-DGIBBON_GRAPHICS=nexus
endif

NETFLIX5_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=bcm-nexus \
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

NETFLIX5_BUILD_DIR=$(@D)/netflix/buildroot-build
NETFLIX5_DATA_DIR=/usr/share/WPEFramework/Netflix

ifeq ($(BR2_PACKAGE_NETFLIX5_LIB),y)

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITORCLIENT),y)
define NETFLIX5_INSTALL_WPEFRAMEWORK_XML
	cp $(@D)/partner/graphics/wpeframework/graphics.xml $(1)
endef
endif

define NETFLIX5_INSTALL
	$(INSTALL) -d $(1)/usr/lib
	$(INSTALL) -m 755 $(NETFLIX5_BUILD_DIR)/src/platform/gibbon/libnetflix.so $(1)/usr/lib
	$(INSTALL) -m 755 $(NETFLIX5_BUILD_DIR)/lib/libJavaScriptCoreNetflix.so $(1)/usr/lib

	$(INSTALL) -d $(1)$(NETFLIX5_DATA_DIR)/resources
	cp -a $(NETFLIX5_BUILD_DIR)/src/platform/gibbon/data/etc $(1)$(NETFLIX5_DATA_DIR)
	cp -a $(NETFLIX5_BUILD_DIR)/src/platform/gibbon/data/fonts $(1)$(NETFLIX5_DATA_DIR)
	cp -a $(NETFLIX5_BUILD_DIR)/src/platform/gibbon/data/resources/img $(1)$(NETFLIX5_DATA_DIR)/resources
	cp -a $(NETFLIX5_BUILD_DIR)/src/platform/gibbon/data/resources/js $(1)$(NETFLIX5_DATA_DIR)/resources
	cp -a $(NETFLIX5_BUILD_DIR)/src/platform/gibbon/data/resources/html $(1)$(NETFLIX5_DATA_DIR)/resources

	$(call NETFLIX5_INSTALL_WPEFRAMEWORK_XML, $(1)$(NETFLIX5_DATA_DIR)/etc/conf)
endef

define NETFLIX5_INSTALL_DEV
	$(call NETFLIX5_INSTALL, $(1))

	$(INSTALL) -d $(1)/usr/lib/pkgconfig
	$(INSTALL) -D package/netflix5/netflix.pc $(1)/usr/lib/pkgconfig/netflix.pc

	$(INSTALL) -d $(1)/usr/include/netflix
	cp -a $(NETFLIX5_BUILD_DIR)/include/* $(1)/usr/include/netflix
	cp -a $(NETFLIX5_BUILD_DIR)/src/platform/gibbon/include/gibbon $(1)/usr/include/netflix

	cp -Rpf $(@D)/netflix/src/platform/gibbon/*.h $(1)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/bridge/*.h $(1)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/text/*.h $(1)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/text/freetype/*.h $(1)/usr/include/netflix

	$(INSTALL) -d $(1)/usr/include/netflix/src
	cd $(@D)/netflix/src && find ./base/ -name "*.h" -exec cp --parents {} $(1)/usr/include/netflix/src \;
	cd $(@D)/netflix/src && find ./nrd/ -name "*.h" -exec cp --parents {} $(1)/usr/include/netflix/src \;
	cd $(@D)/netflix/src && find ./net/ -name "*.h" -exec cp --parents {} $(1)/usr/include/netflix/src \;

	find $(1)/usr/include/netflix/nrdbase/ -name "*.h" -exec sed -i "s/^#include \"\.\.\/\.\.\//#include \"/g" {} \;
  	find $(1)/usr/include/netflix/nrd/ -name "*.h" -exec sed -i "s/^#include \"\.\.\/\.\.\//#include \"/g" {} \;
  	find $(1)/usr/include/netflix/nrdnet/ -name "*.h" -exec sed -i "s/^#include \"\.\.\/\.\.\//#include \"/g" {} \;

	$(INSTALL) -d $(1)/usr/include/netflix/3rdparty
	cp -a $(@D)/netflix/3rdparty/utf8 $(1)/usr/include/netflix/3rdparty
endef

else

define NETFLIX5_INSTALL
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/netflix $(TARGET_DIR)/usr/bin
endef

endif

define NETFLIX5_INSTALL_STAGING_CMDS
	$(call NETFLIX5_INSTALL_DEV, ${STAGING_DIR})
endef

define NETFLIX5_INSTALL_TARGET_CMDS
	$(call NETFLIX5_INSTALL, ${TARGET_DIR})
endef

define NETFLIX5_PREPARE_DPI
	mkdir -p $(TARGET_DIR)/root/Netflix/dpi
	ln -sfn /etc/playready $(TARGET_DIR)/root/Netflix/dpi/playready
endef

NETFLIX5_POST_INSTALL_TARGET_HOOKS += NETFLIX5_PREPARE_DPI

ifeq ($(BR2_PACKAGE_NETFLIX5_CREATE_BINARY_ML_DELIVERY),y)
ML_DELIVERY_NETFLIX5_SIGNATURE=${NETFLIX5_VERSION}
ML_DELIVERY_NETFLIX5_PACKAGE=${NETFLIX5_NAME}
ML_DELIVERY_NETFLIX5_DIR=${STAGING_DIR}/${ML_DELIVERY_NETFLIX5_PACKAGE}
ML_DELIVERY_NETFLIX5_TARBALL=${BINARIES_DIR}/${ML_DELIVERY_NETFLIX5_PACKAGE}-${ML_DELIVERY_NETFLIX5_SIGNATURE}.tar.xz

define CREATE_BINARY_ML_DELIVERY_NETFLIX5
	rm -rf ${ML_DELIVERY_NETFLIX5_DIR} ${ML_DELIVERY_NETFLIX5_TARBALL}
	mkdir -p ${ML_DELIVERY_NETFLIX5_DIR}/usr/lib/pkgconfig/
	mkdir -p ${ML_DELIVERY_NETFLIX5_DIR}/usr/include/
	$(call NETFLIX5_INSTALL_DEV, ${ML_DELIVERY_NETFLIX5_DIR})
	tar -cJf ${ML_DELIVERY_NETFLIX5_TARBALL} -C ${STAGING_DIR} ${ML_DELIVERY_NETFLIX5_PACKAGE}
endef

NETFLIX5_POST_INSTALL_TARGET_HOOKS += CREATE_BINARY_ML_DELIVERY_NETFLIX5
endif

$(eval $(cmake-package))
