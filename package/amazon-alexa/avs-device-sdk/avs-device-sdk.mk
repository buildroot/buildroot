################################################################################
#
# avs-device-sdk
#
################################################################################

AVS_DEVICE_SDK_VERSION = v1.15
AVS_DEVICE_SDK_SITE =  $(call github,alexa,avs-device-sdk,$(AVS_DEVICE_SDK_VERSION))
AVS_DEVICE_SDK_LICENSE = Apache-2.0
AVS_DEVICE_SDK_LICENSE_FILES = LICENSE.txt
AVS_DEVICE_SDK_INSTALL_STAGING = YES
AVS_DEVICE_SDK_DEPENDENCIES = host-cmake openssl libcurl sqlite
AVS_DEVICE_SDK_SUPPORTS_IN_SOURCE_BUILD = NO

define AVS_DEVICE_SDK_EXTRACT_CMDS
	$(TAR) --strip-components=1 $(TAR_OPTIONS) $(AVS_DEVICE_SDK_DL_DIR)/$(AVS_DEVICE_SDK_SOURCE) -C $(@D)
endef

AVS_DEVICE_SDK_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -Wno-error=deprecated-copy" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -Wno-error=deprecated-copy"

ifeq ($(BR2_PACKAGE_AVS_DEVICE_SDK_BUILD_TYPE_DEBUG),y)
AVS_DEVICE_SDK_CONF_OPTS += -DCMAKE_BUILD_TYPE=DEBUG
else ifeq ($(BR2_PACKAGE_AVS_DEVICE_SDK_BUILD_TYPE_RELEASE),y)
AVS_DEVICE_SDK_CONF_OPTS += -DCMAKE_BUILD_TYPE=RELEASE
endif

ifeq ($(BR2_PACKAGE_AVS_DEVICE_SDK_USE_GSTREAMER),y)
AVS_DEVICE_SDK_DEPENDENCIES += gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad gst1-libav
AVS_DEVICE_SDK_CONF_OPTS += -DGSTREAMER_MEDIA_PLAYER=ON
endif

ifeq ($(BR2_PACKAGE_AVS_DEVICE_SDK_MICROPHONE_BACKEND_PORTAUDIO),y)
AVS_DEVICE_SDK_DEPENDENCIES += portaudio
AVS_DEVICE_SDK_CONF_OPTS += -DPORTAUDIO=ON
AVS_DEVICE_SDK_CONF_OPTS += -DPORTAUDIO_LIB_PATH=$(TARGET_DIR)/usr/lib/libportaudio.so
AVS_DEVICE_SDK_CONF_OPTS += -DPORTAUDIO_INCLUDE_DIR=$(STAGING_DIR)/usr/include
endif

$(eval $(cmake-package))
