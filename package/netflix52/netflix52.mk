################################################################################
#
# netflix5.2
#
################################################################################

NETFLIX52_VERSION = df7012268b24f6a568c617d786634c0f0d0579d1
NETFLIX52_SITE = git@github.com:Metrological/netflix.git
NETFLIX52_SITE_METHOD = git
NETFLIX52_LICENSE = PROPRIETARY
NETFLIX52_DEPENDENCIES = freetype icu openjpeg lcms2 jpeg libpng libmng webp harfbuzz expat openssl c-ares nghttp2 libcurl graphite2 tremor libopenh264 fdk-aac
NETFLIX52_INSTALL_TARGET = YES
NETFLIX52_SUBDIR = netflix
NETFLIX52_RESOURCE_LOC = $(call qstrip,${BR2_PACKAGE_NETFLIX52_RESOURCE_LOCATION})

NETFLIX52_CONF_ENV += TOOLCHAIN_DIRECTORY=$(STAGING_DIR)/usr LD=$(TARGET_CROSS)ld
NETFLIX52_CONF_ENV += TARGET_CROSS="$(GNU_TARGET_NAME)-"

NETFLIX52_CONF_OPTS += -DBUILD_REFERENCE=${NETFLIX52_VERSION}
NETFLIX52_SUPPORTS_IN_SOURCE_BUILD = NO

NETFLIX52_CONF_OPTS = \
	-DBUILD_GIBBON_DIRECTORY=$(@D)/partner/gibbon \
	-DCMAKE_INSTALL_PREFIX=$(@D)/release \
	-DNRDP_SYSTEM_PROCESSOR=$(BR2_ARCH) \
	-DDPI_REFERENCE_DRM_NULL=TRUE \
	-DNRDP_HAS_SOFTWAREPLAYER=OFF \
	-DGIBBON_SOFTWARECAPTURE=OFF \
	-DGIBBON_GRAPHICS_GL_API="gles2" \
	-DBUILD_DPI_DIRECTORY=$(@D)/partner/dpi \
	-DCMAKE_OBJCOPY="$(TARGET_CROSS)objcopy" \
	-DCMAKE_STRIP="$(TARGET_CROSS)strip" \
	-DBUILD_COMPILE_RESOURCES=OFF \
	-DBUILD_SHARED_LIBS=OFF \
	-DNRDP_HAS_IPV6=ON \
	-DGIBBON_GRAPHICS_GL_WSYS=egl \
	-DUSE_DISPLAY_INFO=OFF \
	-DUSE_PLAYER_INFO=OFF

NETFLIX52_CONF_ENV += \
	NODE="$(HOST_DIR)/usr/bin/node" \
	NPM="$(HOST_DIR)/usr/bin/npm" \
	
ifeq ($(BR2_PACKAGE_NETFLIX52_BUILD_ML),y)
NETFLIX52_CONF_OPTS += \
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
else ifeq ($(BR2_PACKAGE_NETFLIX52_BUILD_DEBUG),y)
NETFLIX52_CONF_OPTS += \
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
else ifeq ($(BR2_PACKAGE_NETFLIX52_BUILD_RELEASE_DEBUG),y)
NETFLIX52_CONF_OPTS += \
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
else ifeq ($(BR2_PACKAGE_NETFLIX52_BUILD_RELEASE),y)
NETFLIX52_CONF_OPTS += \
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
NETFLIX52_CONF_OPTS += \
	-DUSE_DISPLAY_SETTINGS=1
endif

ifeq ($(BR2_PACKAGE_NETFLIX52_MINIFY_JS),y)
NETFLIX52_CONF_OPTS += \
		-DJS_MINIFY=ON
NETFLIX52_DEPENDENCIES += \
		host-nodejs
		
define NETFLIX52_INSTALL_NODEJS_MODULES
	npm_config_build_from_source=true \
	npm_config_nodedir=$(BUILD_DIR)/host-nodejs-$(NODEJS_VERSION) \
	npm_config_prefix=$(HOST_DIR)/usr \
	$(HOST_DIR)/usr/bin/npm  install -g uglify-js@3.0.28 jsdoc
endef

NETFLIX52_PRE_CONFIGURE_HOOKS += NETFLIX52_INSTALL_NODEJS_MODULES
endif

ifeq ($(BR2_PACKAGE_NETFLIX52_DISABLE_TOOLS), y)
NETFLIX52_CONF_OPTS += \
	-DNRDP_TOOLS=none
else
NETFLIX52_CONF_OPTS += \
	-DNRDP_TOOLS="provisioning"
endif

NETFLIX52_CONF_OPTS += \
	-DDPI_IMPLEMENTATION=gstreamer

NETFLIX52_DEPENDENCIES += gstreamer1 gst1-plugins-base gst1-plugins-bad

ifeq ($(BR2_PACKAGE_NETFLIX52_DRM_OCDM), y)
NETFLIX52_CONF_OPTS += \
	-DDPI_DRM=ocdm
else ifeq ($(BR2_PACKAGE_NETFLIX52_DRM_PLAYREADY), y)
NETFLIX52_DEPENDENCIES += playready
NETFLIX52_CONF_OPTS += \
        -DDPI_DRM=playready2.5
endif

ifeq ($(BR2_PACKAGE_NETFLIX52_LIB), y)
NETFLIX52_INSTALL_STAGING = YES
NETFLIX52_CONF_OPTS += -DGIBBON_MODE=shared
NETFLIX52_FLAGS = -O3 -fPIC
else
NETFLIX52_CONF_OPTS += -DGIBBON_MODE=executable
endif

ifeq ($(BR2_PACKAGE_NETFLIX52_AUDIO_MIXER), y)
NETFLIX52_DEPENDENCIES += libogg tremor
ifeq ($(BR2_PACKAGE_NETFLIX52_AUDIO_MIXER_SOFTWARE), y)
NETFLIX52_CONF_OPTS += -DNRDP_HAS_AUDIOMIXER=ON \
                      -DUSE_AUDIOMIXER_GST=ON
else ifeq ($(BR2_PACKAGE_NETFLIX52_AUDIO_MIXER_NEXUS), y)
NETFLIX52_CONF_OPTS += -DNRDP_HAS_AUDIOMIXER=ON \
                      -DUSE_AUDIOMIXER_NEXUS=ON
endif
else
NETFLIX52_CONF_OPTS += -DNRDP_HAS_AUDIOMIXER=OFF
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITORCLIENT),y)
NETFLIX52_CONF_OPTS += -DGIBBON_GRAPHICS=wpeframework
NETFLIX52_CONF_OPTS += -DGIBBON_INPUT=wpeframework
NETFLIX52_CONF_OPTS += -DGIBBON_PLATFORM=posix 
NETFLIX52_DEPENDENCIES += wpeframework-clientlibraries
endif

ifeq ($(BR2_PACKAGE_NETFLIX52_GST_GL),y)
  NETFLIX52_CONF_OPTS += -DGST_VIDEO_RENDERING=gl
else ifeq ($(BR2_PACKAGE_NETFLIX52_WESTEROS_SINK),y)
  NETFLIX52_CONF_OPTS += -DGST_VIDEO_RENDERING=westeros
  NETFLIX52_DEPENDENCIES += westeros westeros-sink
endif

NETFLIX52_DEPENDENCIES += libgles libegl

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROVISIONPROXY), y)
    NETFLIX52_CONF_OPTS += -DNETFLIX_USE_PROVISION=ON
    NETFLIX52_DEPENDENCIES += wpeframework-clientlibraries
endif

ifneq ($(BR2_PACKAGE_NETFLIX52_KEYMAP),"")
NETFLIX52_CONF_OPTS += -DNETFLIX_USE_KEYMAP=$(call qstrip,$(BR2_PACKAGE_NETFLIX52_KEYMAP))
endif

NETFLIX52_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(CMAKE_C_FLAGS) $(TARGET_CFLAGS) $(NETFLIX52_FLAGS) -I$(STAGING_DIR)/usr/include" \
	-DCMAKE_CXX_FLAGS="$(CMAKE_CXX_FLAGS) $(TARGET_CXXFLAGS) $(NETFLIX52_FLAGS) -I$(STAGING_DIR)/usr/include" \
	-DCMAKE_EXE_LINKER_FLAGS="$(CMAKE_EXE_LINKER_FLAGS) -L$(STAGING_DIR)/usr/lib" \

define NETFLIX52_FIX_CONFIG_XMLS
	mkdir -p $(@D)/netflix/src/platform/gibbon/data/etc/conf
	cp -f $(@D)/netflix/resources/configuration/common.xml $(@D)/netflix/src/platform/gibbon/data/etc/conf/common.xml
	cp -f $(@D)/netflix/resources/configuration/config.xml $(@D)/netflix/src/platform/gibbon/data/etc/conf/config.xml
endef

NETFLIX52_POST_EXTRACT_HOOKS += NETFLIX52_FIX_CONFIG_XMLS

NETFLIX52_BUILD_DIR=$(@D)/netflix/buildroot-build
NETFLIX52_DATA_DIR=/usr/share/WPEFramework/Netflix

ifeq ($(BR2_PACKAGE_NETFLIX52_LIB),y)

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITORCLIENT),y)
define NETFLIX52_INSTALL_WPEFRAMEWORK_XML
	cp $(@D)/partner/gibbon/graphics/wpeframework/graphics.xml $(1)
endef
endif

define NETFLIX52_INSTALL_NETFLIX_DATA_CONFIGS
 	$(INSTALL) -d $(1)$(NETFLIX52_DATA_DIR)/resources
	cp -a $(NETFLIX52_BUILD_DIR)/src/platform/gibbon/data/etc $(1)$(NETFLIX52_DATA_DIR)
	cp -a $(NETFLIX52_BUILD_DIR)/src/platform/gibbon/data/fonts $(1)$(NETFLIX52_DATA_DIR)
	cp -a $(NETFLIX52_BUILD_DIR)/src/platform/gibbon/data/resources/img $(1)$(NETFLIX52_DATA_DIR)/resources
	cp -a $(NETFLIX52_BUILD_DIR)/src/platform/gibbon/data/resources/js $(1)$(NETFLIX52_DATA_DIR)/resources
	cp -a $(NETFLIX52_BUILD_DIR)/src/platform/gibbon/data/resources/html $(1)$(NETFLIX52_DATA_DIR)/resources

	$(INSTALL) -d $(1)$(NETFLIX52_DATA_DIR)/etc/conf
	$(call NETFLIX52_INSTALL_WPEFRAMEWORK_XML, $(1)$(NETFLIX52_DATA_DIR)/etc/conf)
endef

define NETFLIX52_INSTALL_TO_TARGET
	$(INSTALL) -d $(1)/usr/lib
	$(INSTALL) -m 755 $(NETFLIX52_BUILD_DIR)/src/platform/gibbon/libnetflix.so $(1)/usr/lib
	$(INSTALL) -m 755 $(NETFLIX52_BUILD_DIR)/src/platform/gibbon/lib/libJavaScriptCore.so $(1)/usr/lib

	$(call NETFLIX52_INSTALL_NETFLIX_DATA_CONFIGS, $(1))

	mkdir -p $(1)/root/Netflix/artifacts
	cp -r $(@D)/artifacts/MeteringCertificate.bin $(1)/root/Netflix/artifacts

endef

define NETFLIX52_INSTALL_TO_STAGING
	$(call NETFLIX52_INSTALL_TO_TARGET, $(1))

	$(INSTALL) -d $(1)/usr/lib/pkgconfig
	$(INSTALL) -D package/netflix52/netflix.pc $(1)/usr/lib/pkgconfig/netflix.pc

	$(INSTALL) -d $(1)/usr/include/netflix
	rsync -arL $(NETFLIX52_BUILD_DIR)/include/* $(1)/usr/include/netflix

	mkdir -p $(1)/usr/include/3rdparty/JavaScriptCore/Source/WTF/wtf/nrdp
	mkdir -p $(1)/usr/include/3rdparty/lz4
	mkdir -p $(1)/usr/include/3rdparty/utf8

	cp -Rpf $(@D)/netflix/3rdparty/adf/*.h $(1)/usr/include/netflix/
	cp -Rpf $(@D)/netflix/3rdparty/harfbuzz/src/*.h $(1)/usr/include/netflix/
	cp -Rpf $(@D)/netflix/3rdparty/utf8/*.h $(1)/usr/include/3rdparty/utf8/
	cp -Rpf $(@D)/netflix/3rdparty/lz4/lz4.h $(1)/usr/include/3rdparty/lz4/
	cp -Rpf $(@D)/netflix/3rdparty/JavaScriptCore/Source/WTF/wtf/nrdp/Pool.h $(1)/usr/include/3rdparty/JavaScriptCore/Source/WTF/wtf/nrdp/
	cp -Rpf $(@D)/netflix/3rdparty/JavaScriptCore/Source/WTF/wtf/nrdp/Maddy.h $(1)/usr/include/3rdparty/JavaScriptCore/Source/WTF/wtf/nrdp/

	cp -Rpf $(@D)/netflix/src/platform/gibbon/*.h $(1)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/bridge/*.h $(1)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/text/*.h $(1)/usr/include/netflix

	$(INSTALL) -d $(1)/usr/include/netflix/src
	cd $(@D)/netflix/src && find ./base/ -name "*.h" -exec cp --parents {} $(1)/usr/include/netflix/src \;
	cd $(@D)/netflix/src && find ./nrd/ -name "*.h" -exec cp --parents {} $(1)/usr/include/netflix/src \;
	cd $(@D)/netflix/src && find ./net/ -name "*.h" -exec cp --parents {} $(1)/usr/include/netflix/src \;

	find $(1)/usr/include/netflix/nrdbase/ -name "*.h" -exec sed -i "s/^#include \"\.\.\/\.\.\//#include \"/g" {} \;
	find $(1)/usr/include/netflix/nrd/ -name "*.h" -exec sed -i "s/^#include \"\.\.\/\.\.\//#include \"/g" {} \;
	find $(1)/usr/include/netflix/nrdnet/ -name "*.h" -exec sed -i "s/^#include \"\.\.\/\.\.\//#include \"/g" {} \;

	mkdir -p $(1)/usr/include/netflix/3rdparty/utf8/
	cp -Rpf $(@D)/netflix/3rdparty/utf8/* $(1)/usr/include/netflix/3rdparty/utf8/
endef

else

define NETFLIX52_INSTALL_TARGET
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/netflix $(TARGET_DIR)/usr/bin
endef

endif

define NETFLIX52_INSTALL_STAGING_CMDS
	$(call NETFLIX52_INSTALL_TO_STAGING, ${STAGING_DIR})
endef

define NETFLIX52_INSTALL_TARGET_CMDS
	$(call NETFLIX52_INSTALL_TO_TARGET, ${TARGET_DIR})
endef

define NETFLIX52_PREPARE_DPI
	mkdir -p $(TARGET_DIR)/root/Netflix/dpi
	ln -sfn /etc/playready $(TARGET_DIR)/root/Netflix/dpi/playready
endef

NETFLIX52_POST_INSTALL_TARGET_HOOKS += NETFLIX52_PREPARE_DPI

ifeq ($(BR2_PACKAGE_NETFLIX52_CREATE_BINARY_ML_DELIVERY),y)
ML_DELIVERY_SIGNATURE=${NETFLIX52_VERSION}
ML_DELIVERY_PACKAGE=${NETFLIX52_NAME}
ML_DELIVERY_DIR=${STAGING_DIR}/${BINARY_ML_DELIVERY_PACKAGE}

define CREATE_BINARY_ML_DELIVERY
	mkdir -p ${ML_DELIVERY_DIR}/usr/lib/pkgconfig/
	mkdir -p ${ML_DELIVERY_DIR}/usr/include/
	$(call NETFLIX52_INSTALL_TO_STAGING, ${ML_DELIVERY_DIR})
	$(call NETFLIX52_INSTALL_TO_TARGET, ${ML_DELIVERY_DIR})
	mkdir -p ${ML_DELIVERY_DIR}/root/Netflix/dpi
	ln -sfn /etc/playready ${ML_DELIVERY_DIR}/root/Netflix/dpi/playready
	tar -cJf ${BINARIES_DIR}/${ML_DELIVERY_PACKAGE}-${ML_DELIVERY_SIGNATURE}.tar.xz -C ${STAGING_DIR} ${ML_DELIVERY_PACKAGE}
endef

NETFLIX52_POST_INSTALL_TARGET_HOOKS += CREATE_BINARY_ML_DELIVERY
endif

$(eval $(cmake-package))
