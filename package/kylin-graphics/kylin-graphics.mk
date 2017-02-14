################################################################################
#
# kylin-graphics
#
################################################################################

KYLIN_GRAPHICS_VERSION = e2f9baff39058de8cacccf598b2c240c12afe2a6
KYLIN_GRAPHICS_SITE_METHOD = git
KYLIN_GRAPHICS_SITE = git@github.com:Metrological/kylin-graphics.git
KYLIN_GRAPHICS_INSTALL_STAGING = YES
KYLIN_GRAPHICS_DEPENDENCIES += wayland

define KYLIN_GRAPHICS_BUILD_CMDS
    @echo  ' - Precompiled Binaries.'
endef

define KYLIN_GRAPHICS_INSTALL_STAGING_CMDS
    $(call KYLIN_GRAPHICS_INSTALL_LIBS,$(STAGING_DIR))
	$(call KYLIN_GRAPHICS_INSTALL_SERVER_LIBS,$(STAGING_DIR))
	$(call KYLIN_GRAPHICS_INSTALL_HEADERS,$(STAGING_DIR))
	$(call KYLIN_GRAPHICS_INSTALL_PKGCNF,$(STAGING_DIR))
endef

define KYLIN_GRAPHICS_INSTALL_TARGET_CMDS
	$(call KYLIN_GRAPHICS_INSTALL_LIBS,$(TARGET_DIR))
	$(call KYLIN_GRAPHICS_INSTALL_SERVER_LIBS,$(TARGET_DIR))
	$(call KYLIN_GRAPHICS_INSTALL_TESTS,$(TARGET_DIR))
endef

define KYLIN_GRAPHICS_INSTALL_LIBS
  $(INSTALL) -d -m 0755 $(1)/usr/lib
  $(INSTALL) -m 0755 $(@D)/usr/lib/*.so ${1}/usr/lib/
endef

define KYLIN_GRAPHICS_INSTALL_SERVER_LIBS  
  $(INSTALL) -d -m 0755 $(1)/usr/lib/server
  $(INSTALL) -m 0755 $(@D)/usr/lib/server/*.so ${1}/usr/lib/server
endef

define KYLIN_GRAPHICS_INSTALL_HEADERS
  $(INSTALL) -d -m 0755 $(1)/usr/include/GLES2
  $(INSTALL) -d -m 0755 $(1)/usr/include/KHR
  $(INSTALL) -d -m 0755 $(1)/usr/include/EGL 
  $(INSTALL) -m 0755 $(@D)/usr/include/EGL/* ${1}/usr/include/EGL
  $(INSTALL) -m 0755 $(@D)/usr/include/GLES2/* ${1}/usr/include/GLES2
  $(INSTALL) -m 0755 $(@D)/usr/include/KHR/* ${1}/usr/include/KHR
endef

define KYLIN_GRAPHICS_INSTALL_PKGCNF
  $(INSTALL) -d -m 0755 $(1)/usr/lib/pkgconfig
  $(INSTALL) -m 0755 $(@D)/usr/lib/pkgconfig/* ${1}/usr/lib/pkgconfig
endef

define KYLIN_GRAPHICS_INSTALL_TESTS
  $(INSTALL) -d -m 0755 $(1)/usr/bin/
  $(INSTALL) -m 0755 $(@D)/usr/bin/mali_base_jd_test ${1}/usr/bin/mali_base_jd_test
  $(INSTALL) -m 0755 $(@D)/usr/bin/mali_egl_integration_multithread_tests ${1}/usr/bin/mali_egl_integration_multithread_tests
  $(INSTALL) -m 0755 $(@D)/usr/bin/mali_egl_integration_tests ${1}/usr/bin/mali_egl_integration_tests
  $(INSTALL) -m 0755 $(@D)/usr/bin/mali_base_ump_test ${1}/usr/bin/mali_base_ump_test
  $(INSTALL) -m 0755 $(@D)/usr/bin/mali_gles_integration_suite ${1}/usr/bin/mali_gles_integration_suite
  $(INSTALL) -m 0755 $(@D)/usr/bin/ump_test ${1}/usr/bin/ump_test
endef

$(eval $(generic-package))
