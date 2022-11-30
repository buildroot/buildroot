################################################################################
#
# rockchip-mali
#
################################################################################

ROCKCHIP_MALI_VERSION = 721653b5b3b525a4f80d15aa7e2f9df7b7e60427
ROCKCHIP_MALI_SITE = $(call github,JeffyCN,mirrors,$(ROCKCHIP_MALI_VERSION))
ROCKCHIP_MALI_LICENSE = Proprietary
ROCKCHIP_MALI_LICENSE_FILES = END_USER_LICENCE_AGREEMENT.txt
ROCKCHIP_MALI_INSTALL_STAGING = YES
ROCKCHIP_MALI_DEPENDENCIES = host-patchelf libdrm
ROCKCHIP_MALI_PROVIDES = libegl libgles libgbm

ROCKCHIP_MALI_LIB = libmali-bifrost-g31-rxp0$(ROCKCHIP_MALI_SUFFIX).so
ROCKCHIP_MALI_PKGCONFIG_FILES = egl gbm glesv2 mali
ROCKCHIP_MALI_ARCH_DIR = $(if $(BR2_arm)$(BR2_armeb),arm-linux-gnueabihf,aarch64-linux-gnu)
ROCKCHIP_MALI_HEADERS = EGL FBDEV GLES GLES2 GLES3 KHR gbm.h

# We need to create:
# - The symlink that matches the library SONAME (libmali.so.1)
# - The .so symlinks needed at compile time by the compiler (*.so)
ROCKCHIP_MALI_LIB_SYMLINKS = \
	libmali.so.1 \
	libMali.so \
	libEGL.so \
	libgbm.so \
	libGLESv1_CM.so \
	libGLESv2.so

ifeq ($(BR2_PACKAGE_WAYLAND),y)
ROCKCHIP_MALI_SUFFIX = -wayland-gbm
ROCKCHIP_MALI_PKGCONFIG_FILES += wayland-egl
ROCKCHIP_MALI_LIB_SYMLINKS += libwayland-egl.so
ROCKCHIP_MALI_DEPENDENCIES += wayland
else
ROCKCHIP_MALI_SUFFIX = -gbm
endif

define ROCKCHIP_MALI_INSTALL_CMDS
# 	Install the library
	$(INSTALL) -D -m 0755 \
		$(@D)/lib/$(ROCKCHIP_MALI_ARCH_DIR)/$(ROCKCHIP_MALI_LIB) \
		$(1)/usr/lib/$(ROCKCHIP_MALI_LIB)

# 	Ensure it has a proper soname
	$(HOST_DIR)/bin/patchelf --set-soname libmali.so.1 \
		$(1)/usr/lib/$(ROCKCHIP_MALI_LIB)

#	Generate and install the .pc files
	mkdir -p $(1)/usr/lib/pkgconfig
	$(foreach pkgconfig,$(ROCKCHIP_MALI_PKGCONFIG_FILES), \
		sed -e 's%@CMAKE_INSTALL_LIBDIR@%lib%;s%@CMAKE_INSTALL_INCLUDEDIR@%include%' \
			$(@D)/pkgconfig/$(pkgconfig).pc.cmake > \
			$(1)/usr/lib/pkgconfig/$(pkgconfig).pc
	)

#	Install all headers
	$(foreach d,$(ROCKCHIP_MALI_HEADERS), \
		cp -dpfr $(@D)/include/$(d) $(1)/usr/include/
	)

#	Create symlinks
	$(foreach symlink,$(ROCKCHIP_MALI_LIB_SYMLINKS), \
		ln -sf $(ROCKCHIP_MALI_LIB) $(1)/usr/lib/$(symlink)
	)
endef

define ROCKCHIP_MALI_INSTALL_TARGET_CMDS
	$(call ROCKCHIP_MALI_INSTALL_CMDS,$(TARGET_DIR))
endef

define ROCKCHIP_MALI_INSTALL_STAGING_CMDS
	$(call ROCKCHIP_MALI_INSTALL_CMDS,$(STAGING_DIR))
endef

$(eval $(generic-package))
