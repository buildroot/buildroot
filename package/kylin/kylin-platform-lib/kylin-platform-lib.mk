################################################################################
#
# kylin-platform-lib
#
################################################################################

KYLIN_PLATFORM_LIB_VERSION = 4627ec9b0d2a8e400763e5d69b839e7b916b2401
KYLIN_PLATFORM_LIB_SITE_METHOD = git
KYLIN_PLATFORM_LIB_SITE = git@github.com:Metrological/kylin-graphics.git
KYLIN_PLATFORM_LIB_INSTALL_STAGING = YES
KYLIN_PLATFORM_LIB_DEPENDENCIES += wayland

define KYLIN_PLATFORM_LIB_BUILD_CMDS
    @echo  ' - Precompiled Binaries.'
endef

define KYLIN_PLATFORM_LIB_INSTALL_STAGING_CMDS
    $(call KYLIN_PLATFORM_LIB_INSTALL_LIBS,$(STAGING_DIR))
	$(call KYLIN_PLATFORM_LIB_INSTALL_HEADERS,$(STAGING_DIR))
	$(call KYLIN_PLATFORM_LIB_INSTALL_ARCHIVES,$(STAGING_DIR))
	$(call KYLIN_PLATFORM_LIB_INSTALL_PKGCNF,$(STAGING_DIR))
endef

define KYLIN_PLATFORM_LIB_INSTALL_TARGET_CMDS
	$(call KYLIN_PLATFORM_LIB_INSTALL_LIBS,$(TARGET_DIR))
endef

define KYLIN_PLATFORM_LIB_INSTALL_LIBS
  $(INSTALL) -m 0755 -d $(1)/usr/lib/realtek 
  $(INSTALL) -m 0755 $(@D)/android/genericLinux/lib/*.so ${1}/usr/lib/realtek
endef

define KYLIN_PLATFORM_LIB_INSTALL_ARCHIVES
  $(INSTALL) -m 0755 -d $(1)/usr/lib/realtek
  $(INSTALL) -m 0755 $(@D)/android/genericLinux/lib/*.a ${1}/usr/lib/realtek
endef

define KYLIN_PLATFORM_LIB_INSTALL_HEADERS
	$(INSTALL) -m 0755 -d $(1)/usr/include/realtek/genericLinux
	cp -arf $(@D)/android/genericLinux/include ${1}/usr/include/realtek/genericLinux
	cp -arf $(@D)/android/genericLinux/src ${1}/usr/include/realtek/genericLinux
	cp -arf $(@D)/android/bionic ${1}/usr/include/realtek/
	cp -arf $(@D)/android/device ${1}/usr/include/realtek/
	cp -arf $(@D)/android/frameworks ${1}/usr/include/realtek/
	cp -arf $(@D)/android/hardware ${1}/usr/include/realtek/
	cp -arf $(@D)/android/system ${1}/usr/include/realtek/
endef

define KYLIN_PLATFORM_LIB_INSTALL_PKGCNF
  $(INSTALL) -d -m 0755 $(1)/usr/lib/pkgconfig
  $(INSTALL) -m 0755 $(@D)/pkgconfig/* ${1}/usr/lib/pkgconfig
endef


$(eval $(generic-package))
