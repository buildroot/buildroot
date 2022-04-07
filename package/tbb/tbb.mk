################################################################################
#
# tbb
#
################################################################################

TBB_VERSION = 2018_U5
TBB_SITE = $(call github,01org,tbb,$(TBB_VERSION))
TBB_INSTALL_STAGING = YES
TBB_LICENSE = Apache-2.0
TBB_LICENSE_FILES = LICENSE

TBB_SO_VERSION = 2
TBB_LIBS = libtbb libtbbmalloc libtbbmalloc_proxy
TBB_BIN_PATH = $(@D)/build/linux_*

# arch is normally set based on uname -m with some conversions. However,
# it is not really used for much:
# - to decide between 32 or 64-bit files (based on '64' in the name)
# - to decide on some arch-specific CFLAGS like -m32, which we don't actually want
# - to set DO_ITT_NOTIFY if it's x86 (32 or 64 bit)
# - to include assembler source, but it only exists for ia64
# The only thing we actually want from the above is the 32/64-bit, and
# DO_ITT_NOTIFY. Therefore, set arch to a fixed value which is unknown to
# the tbb build system, and set DO_ITT_NOTIFY explicitly.
TBB_ARCH = $(if $(BR2_ARCH_IS_64),buildroot64,buildroot32)
TBB_ITT_NOTIFY = $(if $(BR2_i386)$(BR2_x86_64),-DDO_ITT_NOTIFY)
TBB_CXXFLAGS = $(TARGET_CXXFLAGS) $(TBB_ITT_NOTIFY)

define TBB_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) arch=$(TBB_ARCH) \
		CPLUS="$(TARGET_CXX)" CONLY="$(TARGET_CC)" CXXFLAGS="$(TBB_CXXFLAGS)"
endef

define TBB_INSTALL_LIBS
	$(foreach lib,$(TBB_LIBS),
		$(INSTALL) -D -m 0755 $(TBB_BIN_PATH)/$(lib).so.$(TBB_SO_VERSION) \
			$(1)/usr/lib/$(lib).so.$(TBB_SO_VERSION) ;
		ln -sf $(lib).so.$(TBB_SO_VERSION) $(1)/usr/lib/$(lib).so
	)
endef

define TBB_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include/
	cp -a $(@D)/include/* $(STAGING_DIR)/usr/include/
	$(call TBB_INSTALL_LIBS,$(STAGING_DIR))
endef

define TBB_INSTALL_TARGET_CMDS
	$(call TBB_INSTALL_LIBS,$(TARGET_DIR))
endef

$(eval $(generic-package))
