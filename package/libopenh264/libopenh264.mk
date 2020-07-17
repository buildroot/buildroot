################################################################################
#
# libopenh264
#
################################################################################

ifeq ($(BR2_PACKAGE_NETFLIX52),y)
LIBOPENH264_SITE = git@github.com:Metrological/netflix.git
LIBOPENH264_VERSION = 6431bbf0b8dc7bde39a723dbcd5f224ce2646359
LIBOPENH264_SITE_METHOD = git
else
LIBOPENH264_VERSION = v1.6.0
LIBOPENH264_SITE = $(call github,cisco,openh264,$(LIBOPENH264_VERSION))
endif
LIBOPENH264_LICENSE = BSD-2c
LIBOPENH264_LICENSE_FILES = LICENSE
LIBOPENH264_INSTALL_STAGING = YES

ifeq ($(BR2_aarch64),y)
LIBOPENH264_ARCH = aarch64
else ifeq ($(BR2_arm)$(BR2_armeb),y)
LIBOPENH264_ARCH = arm
else ifeq ($(BR2_i386),y)
LIBOPENH264_ARCH = x86
LIBOPENH264_DEPENDENCIES += host-nasm
else ifeq ($(BR2_mips)$(BR2_mipsel),y)
LIBOPENH264_ARCH = mips
else ifeq ($(BR2_mips64)$(BR2_mips64el),y)
LIBOPENH264_ARCH = mips64
else ifeq ($(BR2_x86_64),y)
LIBOPENH264_ARCH = x86_64
LIBOPENH264_DEPENDENCIES += host-nasm
endif

# ENABLE64BIT is really only used for x86-64, other 64 bits
# architecture don't need it.
LIBOPENH264_MAKE_OPTS = \
    ARCH=$(LIBOPENH264_ARCH) \
    ENABLE64BIT=$(if $(BR2_x86_64),Yes,No)

ifeq ($(BR2_PACKAGE_NETFLIX52),y)

define LIBOPENH264_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/netflix/3rdparty/openh264 \
        $(LIBOPENH264_MAKE_OPTS)
endef

define LIBOPENH264_INSTALL_STAGING_CMDS
	sh $(@D)/netflix/3rdparty/openh264/codec/common/generate_version.sh $(@D)/netflix/3rdparty/openh264/
	
	mkdir -p $(STAGING_DIR)/usr/include/wels
	install -m 644 $(@D)/netflix/3rdparty/openh264/codec/api/svc/codec*.h $(STAGING_DIR)/usr/include/wels

	mkdir -p $(STAGING_DIR)/usr/lib/pkgconfig
	install -m 644 $(@D)/netflix/3rdparty/openh264/openh264.pc.in $(STAGING_DIR)/usr/lib/pkgconfig/openh264.pc

	install -m 644 $(@D)/netflix/3rdparty/openh264/libopenh264.a $(STAGING_DIR)/usr/lib
	install -m 755 $(@D)/netflix/3rdparty/openh264/libopenh264.so* $(STAGING_DIR)/usr/lib
endef

define LIBOPENH264_INSTALL_TARGET_CMDS
	install -m 755 $(@D)/netflix/3rdparty/openh264/libopenh264.so* $(TARGET_DIR)/usr/lib
endef

else

define LIBOPENH264_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
        $(LIBOPENH264_MAKE_OPTS)
endef

define LIBOPENH264_INSTALL_STAGING_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
        $(LIBOPENH264_MAKE_OPTS) \
        DESTDIR=$(STAGING_DIR) PREFIX=/usr install
endef

define LIBOPENH264_INSTALL_TARGET_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
        $(LIBOPENH264_MAKE_OPTS) \
        DESTDIR=$(TARGET_DIR) PREFIX=/usr install
endef

endif

$(eval $(generic-package))